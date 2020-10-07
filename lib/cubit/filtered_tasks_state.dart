part of 'filtered_tasks_cubit.dart';

@immutable
abstract class FilteredTasksState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilteredTasksInitial extends FilteredTasksState {
  @override
  List<Object> get props => [];
}

class FilteredTasksLoading extends FilteredTasksState {
  @override
  List<Object> get props => [];
}

class FilteredTasksLoaded extends FilteredTasksState {
  final List<TaskModel> taskListModel;

  FilteredTasksLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class FilteredTasksEmpty extends FilteredTasksState {
  final String message;

  FilteredTasksEmpty({this.message});

  @override
  List<Object> get props => super.props;
}

class FilteredTasksFailure extends FilteredTasksState {
  final String message;
  FilteredTasksFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class FilteredRemoveTasksSuccess extends FilteredTasksState {
  final String message;

  FilteredRemoveTasksSuccess(this.message);
  @override
  List<Object> get props => [message];
}
