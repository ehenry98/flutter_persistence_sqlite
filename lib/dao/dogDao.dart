import 'package:flutter_app_persistance_sqlite/database/database.dart';
import 'package:flutter_app_persistance_sqlite/model/Dog.dart';
import 'package:sqflite/sqflite.dart';

class DogDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<void> insertDog(Dog dog) async {
    final db = await dbProvider.database; //referencia de la base de datos
    var result = await db.insert('dogs',dog.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final db = await dbProvider.database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await dbProvider.database;
    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await dbProvider.database;
    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

}