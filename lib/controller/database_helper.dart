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
  static const String INGREDIENT_COL_ITEM = 'item';
  static const String INGREDIENT_COL_IN_SHOPPINGLIST = 'inShoppingList';
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
      '$INGREDIENT_COL_ITEM TEXT,'
      '$INGREDIENT_COL_IN_SHOPPINGLIST INT,'
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

  /// Runs the CREATE TABLE commands
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

  /// Retrieve all recipes operation. Get all Recipes from the database
  /// and return a list of Recipes objects
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
  Future<List<String>> getIngredients(int recipeId) async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(INGREDIENT_TABLE_NAME,
        where: '$INGREDIENT_COL_RECIPE_ID = ?', whereArgs: [recipeId]);
    List<String> ingredients = new List<String>();
    for (int index = 0; index < result.length; index++) {
      Map<String, dynamic> ingredient = result[index];
      ingredients.add(ingredient["item"]);
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
    int recipeId;
    try {
      recipeId = await db.rawInsert(INSERT_RECIPE, [
        recipe.label,
        recipe.image,
        recipe.source,
        recipe.url,
      ]);
    } on Exception catch (e) {}

    if (recipeId < 0) {
      // if the recipe insert was unsuccessful then no point continuing
      return -1;
    }

    // add Ingredients to database
    for (int index = 0; index < recipe.ingredientLines.length; index++) {
      insertIngredientString(recipe.ingredientLines[index], recipeId);
    }
    return recipeId;
  }

  /// Create ingredient operation. Insert an ingredient object, [ingredient],
  /// into the database
  /// Returns the inserted object ID
  ///
  Future<int> insertIngredient(Ingredient ingredient) async {
    Database db = await this.database;

    Map<String, dynamic> ingredientMap = ingredient.toJson();

    int result = await db.insert(INGREDIENT_TABLE_NAME, ingredientMap);
    return result;
  }

  /// Create ingredient operation. Insert an ingredient string, [ingredientString],
  /// into the database. Optional [recipeId], defaults to 0 if no value is provided
  /// Returns the inserted object ID
  ///
  Future<int> insertIngredientString(String ingredientString,
      [int recipeId = 0]) async {
    Database db = await this.database;
    // Check if this ingredient already exists in the database
    List<Map> records = await db.rawQuery(
        'SELECT * FROM $INGREDIENT_TABLE_NAME '
        'WHERE $INGREDIENT_COL_ITEM = ?',
        [ingredientString]);
    // If so, return the ingredientId
    if (records.length > 0) {
      return records[0]['id'];
    }
    // If not, add to the database
    Ingredient ingredient = new Ingredient(ingredientString, recipeId);
    int result = await db.insert(INGREDIENT_TABLE_NAME, ingredient.toJson());
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

  Future<bool> addIngredientToShoppingList(int ingredientId) async {
    if (ingredientId < 1) {
      // invalid id
      return false;
    }
    int count = await _database.rawUpdate(
        'UPDATE $INGREDIENT_TABLE_NAME '
        'SET $INGREDIENT_COL_IN_SHOPPINGLIST = 1 '
        'WHERE $INGREDIENT_COL_ID = ?',
        [ingredientId]);

    if (count < 1) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> removeIngredientFromShoppingList(int ingredientId) async {
    if (ingredientId < 1) {
      // invalid id
      return false;
    }
    int count = await _database.rawUpdate(
        'UPDATE $INGREDIENT_TABLE_NAME '
        'SET $INGREDIENT_COL_IN_SHOPPINGLIST = 0 '
        'WHERE $INGREDIENT_COL_ID = ?',
        [ingredientId]);

    if (count < 1) {
      return false;
    } else {
      return true;
    }
  }

  /// Retrieve shopping list. Retrieve all ingredients that are marked as in the list
  Future<List<Ingredient>> getShoppingList() async {
    Database db = await this.database;
    List<Ingredient> shoppingList = new List<Ingredient>();
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM $INGREDIENT_TABLE_NAME WHERE $INGREDIENT_COL_IN_SHOPPINGLIST > 0;');
    for (int index = 0; index < result.length; index++) {
      Ingredient tempIngredient = Ingredient.fromJson(result[index]);
      shoppingList.add(tempIngredient);
    }
    return shoppingList;
  }

  /// Retrieve shopping list as a List of Strings.
  /// Retrieve all ingredients that are marked as in the list
  Future<String> getShoppingListAsStrings() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM $INGREDIENT_TABLE_NAME WHERE $INGREDIENT_COL_IN_SHOPPINGLIST > 0;');

    String shoppingList = "Shopping List:\n";

    for (int index = 0; index < result.length; index++) {
      String tempIngredient = result[index]['item'];
      shoppingList += tempIngredient;
      shoppingList += '\n';
    }
    return shoppingList;
  }
}
