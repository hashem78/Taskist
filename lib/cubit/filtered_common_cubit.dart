import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/foundation.dart';

part 'filtered_common_state.dart';

class FilteredCommonCubit extends Cubit<FilteredCommonState> {
  FilteredCommonCubit() : super(FilteredCommonInitial()) {
    getFirestoreTasks();
  }
  Future<void> getFirestoreTasks() async {
    emit(FilteredCommonLoading());
    try {
      var collection = await FirebaseFirestore.instance
          .collection('tasks')
          .where('predicate', isEqualTo: 'high')
          .get();
      final List<TaskModel> tasks = [];
      var docs = collection.docs.map(
        (e) => TaskModel.fromJson(e.data()),
      );

      docs.forEach(
        (element) {
          tasks.add(element);
        },
      );
      if (tasks.isEmpty) {
        emit(
          FilteredCommonEmpty(message: "No tasks of this priority available"),
        );
      } else {
        emit(FilteredCommonLoaded(tasks));
      }
      return tasks;
    } catch (e) {
      emit(
        FilteredCommonFailure(message: "Failed to retrieve tasks!"),
      );
    }
  }

  Future<void> removeOnlineTask(String id) async {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .delete()
        .whenComplete(
      () {
        emit(FilteredCommonRemoveSuccess("Removed task"));
      },
    );
  }
}
