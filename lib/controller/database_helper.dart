import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recipedient/model/ingredient.dart';
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
  static const String RECIPE_COL_URL = 'url';
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
      '$RECIPE_COL_URL TEXT,'
      '$RECIPE_COL_DATE_ADDED TEXT'
      ');';

  static const String CREATE_INGREDIENT_TABLE =
      'CREATE TABLE $INGREDIENT_TABLE_NAME ('
      '$INGREDIENT_COL_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$INGREDIENT_ITEM TEXT,'
      '$INGREDIENT_COL_RECIPE_ID INTEGER,'
      'FOREIGN KEY ($INGREDIENT_COL_RECIPE_ID) '
      'REFERENCES $RECIPE_TABLE_NAME($RECIPE_COL_ID)'
      ');';

  static const String INSERT_RECIPE =
      'INSERT INTO $RECIPE_TABLE_NAME (label, image, source, url, dateAdded) '
      'VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP);';

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
      return null;
    }
  }

  /// Retrieve all recipes operation. Get all Recipe objects from the database
  /// as a map
  ///
  Future<List<Map<String, dynamic>>> getRecipeMapList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(RECIPE_TABLE_NAME);
    return result;
  }

  /// Retrieve all recipes operation. Get all Recipe objects from the database
  /// and return a list of Recipes
  ///
  Future<List<Recipe>> getRecipesList() async {
    List<Map<String, dynamic>> recipeMap = await getRecipeMapList();
    List<Recipe> recipes = new List<Recipe>();

    for (int index = 0; index < recipeMap.length; index++) {
      Recipe tempRecipe = Recipe.fromJson(recipeMap[index]);
      List<String> ingredients = new List<String>();
      ingredients = await getIngredients(tempRecipe.id);
      tempRecipe.ingredientLines = ingredients;
      recipes.add(tempRecipe);
    }
    return recipes;
  }

  /// Retrieve ingredients operation. Retrieve all ingredients for a Recipe object.
  ///
  Future<List<String>> getIngredients(int id) async {
    // TODO: Fix this
    Database db = await this.database;
    List<Map<String, String>> result = await db.query(INGREDIENT_TABLE_NAME,
        where: '$INGREDIENT_COL_RECIPE_ID=?', whereArgs: [id]);

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
    // int result = await db.insert(RECIPE_TABLE_NAME, recipe.toJson());

    // insert the Recipe
    int recipeResult;
    try {
      recipeResult = await db.rawInsert(INSERT_RECIPE, [
        recipe.label,
        recipe.image,
        recipe.source,
        recipe.url,
      ]);
    } on Exception catch (e) {}

    if (recipeResult < 0) {
      // if the recipe insert was unsuccessful then no point continuing
      return -1;
    }

    // add Ingredients to database
    for (int index = 0; index < recipe.ingredientLines.length; index++) {
      Ingredient ingredient =
          new Ingredient(recipe.ingredientLines[index], recipeResult);
      try {
        int ingredientResult = await insertIngredient(ingredient);
        if (ingredientResult < 0) {
          throw new Exception(
              'Unable to insert ingredient ${recipe.ingredientLines[index]}');
        }
      } on Exception catch (e) {
        print('Exception inserting ingredient: $e');
      }
    }
    return recipeResult;
  }

  /// Create ingredient operation. Insert an ingredient, [ingredient], into the database
  /// Returns the inserted object ID
  ///
  Future<int> insertIngredient(Ingredient ingredient) async {
    Database db = await this.database;

    Map<String, dynamic> ingredientMap = ingredient.toJson();

    int result = await db.insert(INGREDIENT_TABLE_NAME, ingredientMap);
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
