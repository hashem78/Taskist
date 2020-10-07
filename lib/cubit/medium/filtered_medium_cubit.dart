import 'package:Taskist/models/task_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'filtered_medium_state.dart';

class FilteredMediumCubit extends Cubit<FilteredMediumState> {
  FilteredMediumCubit() : super(FilteredMediumInitial()) {
    getFirestoreTasks();
  }
  Future<void> getFirestoreTasks() async {
    emit(FilteredMediumLoading());
    try {
      var collection = await FirebaseFirestore.instance
          .collection('tasks')
          .where('predicate', isEqualTo: 'medium')
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
          FilteredMediumEmpty(message: "No tasks of this priority available"),
        );
      } else {
        emit(FilteredMediumLoaded(tasks));
      }
      return tasks;
    } catch (e) {
      emit(
        FilteredMediumFailure(message: "Failed to retrieve tasks!"),
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
        emit(FilteredMediumRemoveSuccess("Removed task"));
      },
    );
  }
}
