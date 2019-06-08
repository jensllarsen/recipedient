import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:sqflite/sqflite.dart';

/// [DatabaseHelper] contains helper methods on fields to work with the database
///
/// [DatabaseHelper] is a singleton
///
class DatabaseHelper {
  static const String _DB_NAME = 'recipedient.db';
  static const int _DB_VERSION = 1;

  static const String RECIPE_TABLE_NAME = 'Recipe';
  static const String RECIPE_COL_ID = 'id';
  static const String RECIPE_COL_LABEL = 'label';
  static const String RECIPE_COL_IMAGE = 'image';
  static const String RECIPE_COL_SOURCE = 'source';
  static const String RECIPE_COL_DATE_ADDED = 'dateAdded';

  static const String INGREDIENT_TABLE_NAME = 'Ingredient';
  static const String INGREDIENT_COL_ID = 'id';
  static const String INGREDIENT_ITEM = 'item';
  static const String INGREDIENT_COL_RECIPE_ID = 'recipeId';

  static const String CREATE_RECIPE_TABLE = 'CREATE TABLE $RECIPE_TABLE_NAME ('
      '$RECIPE_COL_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$RECIPE_COL_LABEL TEXT,'
      '$RECIPE_COL_IMAGE TEXT,'
      '$RECIPE_COL_SOURCE TEXT,'
      '$RECIPE_COL_DATE_ADDED INTEGER'
      ');';

  static const String CREATE_INGREDIENT_TABLE =
      'CREATE TABLE $INGREDIENT_TABLE_NAME ('
      '$INGREDIENT_COL_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$INGREDIENT_ITEM TEXT,'
      '$INGREDIENT_COL_RECIPE_ID INTEGER,'
      'FOREIGN KEY ($INGREDIENT_COL_RECIPE_ID) '
      'REFERENCES $RECIPE_TABLE_NAME($RECIPE_COL_ID)'
      ');';

  DatabaseHelper._createInstance();

  // Singleton DatabaseHelper
  static DatabaseHelper _databaseHelper;

  // Local database object
  static Database _database;

  /// factory constructor that makes sure only one instance of
  /// [_databaseHelper] is created
  ///
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  /// Returns the instance of [_database]
  ///
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDb();
    }
    return _database;
  }

  /// Runs the CREATE TABLE command
  ///
  void _createDb(Database db, int newVersion) async {
    print("Creating Recipe table: $CREATE_RECIPE_TABLE");
    print("Creating Ingredient table: $CREATE_INGREDIENT_TABLE");

    await db.execute(CREATE_RECIPE_TABLE);
    await db.execute(CREATE_INGREDIENT_TABLE);
  }

  /// Creates and opens the database
  ///
  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = directory.path + '/' + _DB_NAME;

    try {
      Database recipeDb =
          await openDatabase(dbPath, version: _DB_VERSION, onCreate: _createDb);
      return recipeDb;
    } catch (e) {
      print('Unable to initialize database: $e');
    }
    return null;
  }

  /// Retrieve all recipes operation. Get all Recipe objects from the database
  ///
  Future<List<Map<String, dynamic>>> getRecipeMapList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(RECIPE_TABLE_NAME);
    return result;
  }

  /// Retrieve ingredients operation. Retrieve all ingredients for a Recipe object.
  ///
  Future<List<String>> getIngredients(int id) async {
    // TODO: Fix this
    Database db = await this.database;
    List<Map<String, String>> result = await db.query(INGREDIENT_TABLE_NAME,
        where: '$RECIPE_COL_ID=?', whereArgs: [id]);

    List<String> ingredients;
    for (int index = 0; index < result.length; index++) {
      Map<String, String> ingredient = result[index];
      ingredients.add(ingredient['item']);
    }
    return ingredients;
  }

  /// Create recipe operation. Insert a Recipe object, [recipe], into the database
  /// Returns the inserted object ID
  ///
  Future<int> insertRecipe(Recipe recipe) async {
    Database db = await this.database;
    int result = await db.insert(RECIPE_TABLE_NAME, recipe.toJson());
    return result;
  }

  /// Create ingredient operation. Insert an ingredient, [ingredient], into the database
  /// Returns the inserted object ID
  ///
  Future<int> insertIngredient(String ingredientString) async {
    Database db = await this.database;

    Map<String, dynamic> ingredient = {
      DatabaseHelper.INGREDIENT_ITEM: ingredientString
    };

    int result = await db.insert(INGREDIENT_TABLE_NAME, ingredient);
    return result;
  }

  /// Update recipe operation. Update a Recipe object.
  ///
  Future<int> updateRecipe(Recipe recipe) async {
    Database db = await this.database;
    int result = await db.update(RECIPE_TABLE_NAME, recipe.toJson(),
        where: '$RECIPE_COL_ID=?', whereArgs: [recipe.id]);
    return result;
  }

  /// Delete recipe operation. Delete a Recipe object from the database
  ///
  Future<int> deleteRecipe(int id) async {
    Database db = await this.database;
    int result = await db
        .rawDelete('DELETE FROM $RECIPE_TABLE_NAME WHERE $RECIPE_COL_ID=$id');
    return result;
  }

  /// Delete ingredient operation. Delete an ingredient from the database
  ///
  Future<int> deleteIngredient(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $INGREDIENT_TABLE_NAME WHERE $INGREDIENT_COL_ID=$id');
    return result;
  }

  /// Returns a count of the Recipes currently in the database
  ///
  Future<int> getNumRecipes() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $RECIPE_TABLE_NAME');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
