import 'package:Taskist/cubit/tasks/common_state.dart';
import 'package:Taskist/models/task.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/repositories/local.dart';
import 'package:bloc/bloc.dart';

class LocalTasksCubit extends Cubit<CommonTasksState> {
  LocalTasksCubit({
    this.localName = 'localData',
  })  : _repository = LocalTasksRepository(localName),
        super(CommonTasksInitial());
  final String localName;

  final LocalTasksRepository _repository;

  Future<void> fetch() async {
    var _values = await _repository.fetch();
    _response(_values);
  }

  Future<void> remove(String id) async {
    await _repository.remove(id);
    emit(CommonTaskRemoved());
    await fetch();
  }

  Future<void> add(TaskModel model) async {
    await _repository.add(model);
    await fetch();
  }

  Future<void> removeFiltered(
      String id, TaskPriorityPredicate predicate) async {
    emit(CommonTaskRemoved());
    await _repository.remove(id);
    var _value = await _repository.filter(predicate);
    _response(_value);
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
