import 'package:Taskist/models/task.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/repositories/online_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'online_tasks_state.dart';

class OnlineTasksCubit extends Cubit<OnlineTasksState> {
  OnlineTasksCubit({
    this.onlineName = 'tasks',
  })  : _repository = OnlineTasksRepository(onlineName),
        super(OnlineTasksInitial());
  final String onlineName;
  final OnlineTasksRepository _repository;

  void fetch() {
    emit(OnlineTasksLoading());
    _repository.fetch().then((value) => _response(value));
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
        OnlineTasksEmpty(message: "There are no tasks to show!"),
      );
    } else {
      emit(
        OnlineTasksLoaded(
            message: "Fetched latest tasks sucessfully", tasks: value),
      );
    }
  }
}
