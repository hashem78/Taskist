part of 'task_form_cubit.dart';

@immutable
abstract class TaskFormState extends Equatable {
  const TaskFormState();

  @override
  List<Object> get props => [];
}

class TaskFormInitial extends TaskFormState {
  final TaskFormModel taskFormModel = TaskFormModel(
    priorityPredicate: NoPriorityPredicate(),
    repeats: List<bool>.filled(7, false),
  );
  @override
  List<Object> get props => super.props;
}

class TaskFormDaysChanged extends TaskFormState {
  final List<bool> buttonsState;

  TaskFormDaysChanged({
    @required this.buttonsState,
  });
  @override
  List<Object> get props => [buttonsState];
}

class TaskFormSubmitted extends TaskFormState {
  final TaskModel taskFormModel;

  TaskFormSubmitted({
    @required this.taskFormModel,
  });

  @override
  List<Object> get props => [taskFormModel];
}

class TaskFormUpdate extends TaskFormState {
  final TaskFormModel taskFormModel;

  TaskFormUpdate({
    @required this.taskFormModel,
  });

  @override
  List<Object> get props => [taskFormModel];
}
