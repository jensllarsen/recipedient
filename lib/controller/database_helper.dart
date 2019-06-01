import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:sqflite/sqflite.dart';

/// [DatabaseHelper] contains helper methods on fields to work with the database
///
/// [DatabaseHelper] is a singleton
///
class DatabaseHelper {
  final String dbName = 'recipedient.db';
  final int dbVersion = 1;

  final String recipeTableName = 'recipe_table';
  final String colId = 'id';
  final String colUri = 'uri';
  final String colLabel = 'label';
  final String colImage = 'image';
  final String colSource = 'source';
  final String colUrl = 'url';
  final String colShareAs = 'shareAs';
  final String colRecipeYield = 'recipeYield';
  final String colDietLabels = 'dietLabels';
  final String colHealthLabels = 'colHealthLables';
  final String colCautions = 'cautions';
  final String colIngredientLines = 'ingredientLines';

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
    await db.execute('CREATE TABLE $recipeTableName ('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colUri TEXT,'
        '$colLabel TEXT,'
        '$colImage TEXT,'
        '$colSource TEXT,'
        '$colUrl TEXT,'
        '$colShareAs TEXT,'
        '$colRecipeYield REAL,'
        '$colDietLabels TEXT,'
        '$colHealthLabels TEXT,'
        '$colCautions TEXT,'
        '$colIngredientLines TEXT'
        ');');
  }

  /// Creates and opens the database
  ///
  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = directory.path + dbName;

    Database recipeDb =
        await openDatabase(dbPath, version: dbVersion, onCreate: _createDb);
    return recipeDb;
  }

  /// Retrieve operation. Get all Recipe objects from the database
  ///
  Future<List<Map<String, dynamic>>> getRecipeMapList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(recipeTableName);
    return result;
  }

  /// Create operation. Insert a Recipe object, [recipe], into the database
  /// Returns the inserted object ID
  ///
  Future<int> insertRecipe(Recipe recipe) async {
    Database db = await this.database;
    int result = await db.insert(recipeTableName, recipe.toJson());
    return result;
  }

  /// Update operation. Update a Recipe object.
  ///
  Future<int> updateRecipe(Recipe recipe) async {
    Database db = await this.database;
    int result = await db.update(recipeTableName, recipe.toJson(),
        where: '$colId=?', whereArgs: [recipe.id]);
    return result;
  }

  /// Delete operation. Delete a Recipe object from the database
  ///
  Future<int> deleteRecipe(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $recipeTableName WHERE $colId=$id');
    return result;
  }

  /// Returns a count of the Recipes currently in the database
  ///
  Future<int> getNumRecipes() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $recipeTableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
