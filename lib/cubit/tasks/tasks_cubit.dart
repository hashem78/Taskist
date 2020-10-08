import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/models/task_predicate_model.dart';
import 'package:Taskist/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({
    this.onlineName = 'tasks',
    this.localName = 'localData',
  })  : _repository = TasksRepository(onlineName, localName),
        super(TasksInitial());
  final String localName;
  final String onlineName;
  final TasksRepository _repository;

  void fetchOnline() {
    emit(TasksLoading());
    _repository.fetchOnline().then((value) => _response(value));
  }

  Future<void> fetchLocal() async {
    emit(TasksLoading());
    await _repository.fetchLocal().then((value) => _response(value));
  }

  void fetchAll() {
    emit(TasksLoading());
    _repository.fetchAll().then((value) => _response(value));
  }

  Future<void> remove(String id) async {
    await _repository.remove(id);
  }

  Future<void> add(TaskModel model) async {
    await _repository.add(model);
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
