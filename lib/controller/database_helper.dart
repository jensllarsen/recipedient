import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// [DatabaseHelper] contains helper methods on fields to work with the database
///
/// [DatabaseHelper] is a singleton
///
class DatabaseHelper {
  // Singleton DatabaseHelper
  static DatabaseHelper _databaseHelper;

  // Local database object
  static Database _database;

  DatabaseHelper._createInstance();

  String recipeTableName = 'recipe_table';
  String colId = 'id';
  String colUri = 'uri';
  String colLabel = 'label';
  String colImage = 'image';
  String colSource = 'source';
  String colUrl = 'url';
  String colShareAs = 'shareAs';
  String colRecipeYield = 'recipeYield';
  String colDietLabels = 'dietLabels';
  String colHealthLabels = 'colHealthLables';
  String colCautions = 'cautions';
  String colIngredientLines = 'ingredientLines';

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
        ')');
  }

  /// Creates and opens the database
  ///
  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = directory.path + 'recipedient.db';

    Database recipeDb =
        await openDatabase(dbPath, version: 1, onCreate: _createDb);
    return recipeDb;
  }
}
