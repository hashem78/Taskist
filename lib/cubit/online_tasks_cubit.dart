import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Taskist/models/task_model.dart';
import 'dart:collection';
part 'online_tasks_state.dart';

class OnlineTasksCubit extends Cubit<OnlineTasksState> {
  OnlineTasksCubit() : super(OnlineTasksInitial());
  void firstTimeLoad() {
    getFirestoreTasks().then(
      (tasks) {
        if (tasks.isEmpty)
          emit(
            OnlineTasksEmpty("Online", "No online tasks to show!"),
          );
        else
          emit(
            OnlineFirstTimeTasksLoaded(
              UnmodifiableListView(tasks as List<TaskModel>),
            ),
          );
      },
    );
  }

  Future<List> getFirestoreTasks() async {
    emit(OnlineTasksLoading());
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

  Future<void> removeOnlineTask(String id) async {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .delete()
        .whenComplete(
      () {
        emit(OnlineRemoveTasksSuccess("Removed task"));
        getFirestoreTasks().then(
          (tasks) {
            if (tasks.isEmpty)
              emit(
                OnlineTasksEmpty("Online", "No online tasks to show!"),
              );
            else
              emit(
                OnlineTasksLoaded(
                  UnmodifiableListView(tasks as List<TaskModel>),
                ),
              );
          },
        );
      },
    );
  }
}
