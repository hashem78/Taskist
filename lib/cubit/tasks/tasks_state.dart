part of 'tasks_cubit.dart';

@immutable
abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoaded extends TasksState {
  final String message;
  final List<TaskModel> tasks;
  TasksLoaded({
    @required this.message,
    @required this.tasks,
  });
  @override
  List<Object> get props => [tasks, message];
}

class TasksFailure extends TasksState {
  final String message;

  TasksFailure({@required this.message});
  @override
  List<Object> get props => [message];
}

class TasksEmpty extends TasksState {
  final String message;
  final List<TaskModel> tasks = const [];

  TasksEmpty({@required this.message});
  @override
  List<Object> get props => [message];
}

class TasksLoading extends TasksState {
  @override
  List<Object> get props => [];
}
