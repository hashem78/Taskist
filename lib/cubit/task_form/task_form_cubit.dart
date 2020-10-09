import 'package:Taskist/models/task_form.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'task_form_state.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit() : super(TaskFormInitial());

  TaskFormModel taskFormModel = TaskFormModel(
    priorityPredicate: NoPriorityPredicate(),
    repeats: List<bool>.filled(7, false),
  );

  void updateDayButtons(int index) {
    List<bool> repeats = [...taskFormModel.repeats];
    repeats[index] = !repeats[index];
    taskFormModel = taskFormModel.copyWith(repeats: repeats);
    emit(TaskFormUpdate(taskFormModel: taskFormModel));
  }

  void updatePredicate(TaskPriorityPredicate predicate) {
    taskFormModel = taskFormModel.copyWith(priorityPredicate: predicate);
    emit(TaskFormUpdate(taskFormModel: taskFormModel));
  }
}
