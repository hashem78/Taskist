import 'package:Taskist/models/task.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CommonTasksState extends Equatable {
  const CommonTasksState();

  @override
  List<Object> get props => [];
}

class CommonTasksInitial extends CommonTasksState {}

class CommonTasksLoaded extends CommonTasksState {
  final String message;
  final List<TaskModel> tasks;
  CommonTasksLoaded({
    @required this.message,
    @required this.tasks,
  });
  @override
  List<Object> get props => [tasks, message];
}

class CommonTasksFailure extends CommonTasksState {
  final String message;

  CommonTasksFailure({@required this.message});
  @override
  List<Object> get props => [message];
}

class CommonTasksEmpty extends CommonTasksState {
  final String message;
  final List<TaskModel> tasks = const [];

  CommonTasksEmpty({@required this.message});
  @override
  List<Object> get props => [message];
}

class CommonTasksLoading extends CommonTasksState {
  @override
  List<Object> get props => [];
}

class CommonTaskRemoved extends CommonTasksState {
  final TaskModel model;

  CommonTaskRemoved({@required this.model});

  @override
  List<Object> get props => [];
}
