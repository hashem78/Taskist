part of 'online_tasks_cubit.dart';

@immutable
abstract class OnlineTasksState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnlineTasksInitial extends OnlineTasksState {
  @override
  List<Object> get props => [];
}

class OnlineTasksLoading extends OnlineTasksState {
  @override
  List<Object> get props => [];
}

class OnlineTasksLoaded extends OnlineTasksState {
  final List<TaskModel> taskListModel;

  OnlineTasksLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class OnlineFirstTimeTasksLoaded extends OnlineTasksState {
  final List<TaskModel> taskListModel;

  OnlineFirstTimeTasksLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class OnlineTasksEmpty extends OnlineTasksState {
  final String message;
  final String title;

  OnlineTasksEmpty(this.title, this.message);

  @override
  List<Object> get props => super.props;
}

class OnlineTasksFailure extends OnlineTasksState {
  final String message;
  OnlineTasksFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class OnlineRemoveTasksSuccess extends OnlineTasksState {
  final String message;

  OnlineRemoveTasksSuccess(this.message);
  @override
  List<Object> get props => [message];
}
