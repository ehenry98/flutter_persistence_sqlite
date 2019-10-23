import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_persistance_sqlite/repository/DogRepository.dart';
import 'dart:developer' as developer;

import '../model/Dog.dart';

class DogBloc extends Bloc {
  final _dogRepository = DogRepository();

  final _dogController = StreamController<List<Dog>>.broadcast();

  get dogs => _dogController.stream;

  DogBloc() {
    getDogs();
  }

  void getDogs() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    List<Dog> list = await _dogRepository.allDogs();
    developer.log(list.length.toString(), name: "bloc");
    _dogController.sink.add(list);
  }

  addDog(Dog dog) async {
    await _dogRepository.insertDog(dog);
    getDogs();


  }

  updateDog(Dog dog) async {
    await _dogRepository.updateTodo(dog);
    getDogs();
  }

  deleteDogById(int id) async {
   await _dogRepository.deleteDogById(id);
    getDogs();
  }

  dispose(){
    _dogController.close();
  }

  @override
  // TODO: implement initialState
  get initialState => null;

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    return null;
  }
}