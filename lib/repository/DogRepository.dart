import 'package:flutter_app_persistance_sqlite/dao/dogDao.dart';
import 'package:flutter_app_persistance_sqlite/model/Dog.dart';

class DogRepository {
  final dogDao = DogDao();
  Future allDogs() => dogDao.dogs();
  Future insertDog(Dog dog) => dogDao.insertDog(dog);
  Future updateTodo(Dog todo) => dogDao.updateDog(todo);
  Future deleteDogById(int id) => dogDao.deleteDog(id);
}