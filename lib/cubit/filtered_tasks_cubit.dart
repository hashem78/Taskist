import 'package:Taskist/models/taskpriority_model.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Taskist/models/task_model.dart';
part 'filtered_tasks_state.dart';

class FilteredTasksCubit extends Cubit<FilteredTasksState> {
  FilteredTasksCubit() : super(FilteredTasksInitial());
  void getWithfilter(TaskPriorityPredicate predicate) {
    emit(FilteredTasksLoading());
    getFirestoreTasks().then(
      (value) {
        final filteredTasks = <TaskModel>[];
        value.forEach(
          (element) {
            try {
              if (predicate == element.predicate) {
                filteredTasks.add(element);
              }
            } on NoSuchMethodError {
              emit(
                FilteredTasksFailure(
                    message: "Type supplied doesn't support model"),
              );
              return;
            }
          },
        );
        if (filteredTasks.isEmpty) {
          emit(
            FilteredTasksEmpty(
                message:
                    "There are no tasks of ${predicate.toString()} priority available"),
          );
        } else {
          emit(
            FilteredTasksLoaded(
              filteredTasks,
            ),
          );
        }
      },
    );
  }

  Future<List> getFirestoreTasks() async {
    var collection = await FirebaseFirestore.instance.collection('tasks').get();
    final List<TaskModel> tasks = [];
    var docs = collection.docs.map(
      (e) => TaskModel.fromJson(e.data()),
    );
    docs.forEach(
      (element) {
        tasks.add(element);
      },
    );
    return tasks;
  }

  Future<void> removeOnlineTask(TaskModel task) async {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(task.taskId)
        .delete()
        .whenComplete(
      () {
        emit(FilteredRemoveTasksSuccess("Removed task"));
        getWithfilter(task.predicate);
      },
    );
  }
}
