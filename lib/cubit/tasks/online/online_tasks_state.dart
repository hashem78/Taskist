part of 'online_tasks_cubit.dart';

@immutable
abstract class OnlineTasksState extends Equatable {
  const OnlineTasksState();

  @override
  List<Object> get props => [];
}

class OnlineTasksInitial extends OnlineTasksState {}

class OnlineTasksLoaded extends OnlineTasksState {
  final String message;
  final List<TaskModel> tasks;
  OnlineTasksLoaded({
    @required this.message,
    @required this.tasks,
  });
  @override
  List<Object> get props => [tasks, message];
}

class OnlineTasksFailure extends OnlineTasksState {
  final String message;

  OnlineTasksFailure({@required this.message});
  @override
  List<Object> get props => [message];
}

class OnlineTasksEmpty extends OnlineTasksState {
  final String message;
  final List<TaskModel> tasks = const [];

  OnlineTasksEmpty({@required this.message});
  @override
  List<Object> get props => [message];
}

class OnlineTasksLoading extends OnlineTasksState {
  @override
  List<Object> get props => [];
}
