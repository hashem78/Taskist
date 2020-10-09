import 'package:Taskist/models/task.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/repositories/local_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
part 'local_tasks_state.dart';

class LocalTasksCubit extends Cubit<LocalTasksState> {
  LocalTasksCubit({
    this.localName = 'localData',
  })  : _repository = LocalTasksRepository(localName),
        super(LocalTasksInitial());
  final String localName;

  final LocalTasksRepository _repository;

  Future<void> fetch() async {
    emit(LocalTasksLoading());
    await _repository.fetch().then((value) => _response(value));
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
        LocalTasksEmpty(message: "There are no tasks to show!"),
      );
    } else {
      emit(
        LocalTasksLoaded(
            message: "Fetched latest tasks sucessfully", tasks: value),
      );
    }
  }
}
