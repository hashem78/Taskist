part of 'local_tasks_cubit.dart';

@immutable
abstract class LocalTasksState extends Equatable {
  const LocalTasksState();

  @override
  List<Object> get props => [];
}

class LocalTasksInitial extends LocalTasksState {}

class LocalTasksLoaded extends LocalTasksState {
  final String message;
  final List<TaskModel> tasks;
  LocalTasksLoaded({
    @required this.message,
    @required this.tasks,
  });
  @override
  List<Object> get props => [tasks, message];
}

class LocalTasksFailure extends LocalTasksState {
  final String message;

  LocalTasksFailure({@required this.message});
  @override
  List<Object> get props => [message];
}

class LocalTasksEmpty extends LocalTasksState {
  final String message;
  final List<TaskModel> tasks = const [];

  LocalTasksEmpty({@required this.message});
  @override
  List<Object> get props => [message];
}

class LocalTasksLoading extends LocalTasksState {
  @override
  List<Object> get props => [];
}
