import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/models/task_predicate_model.dart';
import 'package:Taskist/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({
    this.localName = 'localData',
    this.onlineName = 'tasks',
  })  : _repository = Repository.init(localName, onlineName),
        super(TasksInitial());
  final String localName;
  final String onlineName;
  final Repository _repository;

  void fetchOnline() {
    emit(TasksLoading());
    _repository.fetchOnline().then((value) => _response(value));
  }

  void fetchLocal() {
    emit(TasksLoading());
    _repository.fetchLocal().then((value) => _response(value));
  }

  void fetchAll() {
    emit(TasksLoading());
    _repository.fetchAll().then((value) => _response(value));
  }

  void fetchWithFilter(TaskPriorityPredicate predicate) {}

  void _response(List<TaskModel> value) {
    if (value.isEmpty) {
      emit(
        TasksEmpty(message: "There are no tasks to show!"),
      );
    } else {
      emit(
        TasksLoaded(message: "Fetched latest tasks sucessfully", tasks: value),
      );
    }
  }
}
