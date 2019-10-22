import 'dart:async';

import 'package:flutter_app_persistance_sqlite/repository/DogRepository.dart';

import '../model/Dog.dart';

class DogBloc {
  final _dogRepository = DogRepository();

  final _dogController = StreamController<List<Dog>>.broadcast();

  get dogs => _dogController.stream;

  DogBloc() {
    getDogs();
  }

  getDogs({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _dogController.sink.add(await _dogRepository.allDogs());
  }

  addDog(Dog dog) async {
    await _dogRepository.insertDog(dog);
    _dogController.sink.add(await _dogRepository.allDogs());
  }

  updateDog(Dog dog) async {
    await _dogRepository.updateTodo(dog);
    _dogController.sink.add(await _dogRepository.allDogs());
  }

  deleteDogById(int id) async {
    _dogRepository.deleteDogById(id);
    getDogs();
  }
}