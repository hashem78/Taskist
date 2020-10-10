import 'package:Taskist/cubit/tasks/common_state.dart';
import 'package:Taskist/models/task.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/repositories/online.dart';
import 'package:bloc/bloc.dart';

class OnlineTasksCubit extends Cubit<CommonTasksState> {
  OnlineTasksCubit({
    this.onlineName = 'tasks',
  })  : _repository = OnlineTasksRepository(onlineName),
        super(CommonTasksInitial());
  final String onlineName;
  final OnlineTasksRepository _repository;

  Future<void> fetch() async {
    var value = await _repository.fetch();
    _response(value);
  }

  Future<void> remove(String id) async {
    emit(CommonTaskRemoved());
    await _repository.remove(id);
    await fetch();
  }

  Future<void> removeFiltered(
      String id, TaskPriorityPredicate predicate) async {
    emit(CommonTaskRemoved());
    await _repository.remove(id);
    var _value = await _repository.filter(predicate);
    _response(_value);
  }

  Future<void> add(TaskModel model) async {
    await _repository.add(model);
    await fetch();
  }

  void filter(TaskPriorityPredicate predicate) async {
    var _value = await _repository.filter(predicate);
    _response(_value);
  }

  void _response(List<TaskModel> value) {
    if (value.isEmpty) {
      emit(
        CommonTasksEmpty(message: "There are no tasks to show!"),
      );
    } else {
      emit(
        CommonTasksLoaded(
            message: "Fetched latest tasks sucessfully", tasks: value),
      );
    }
  }
}
