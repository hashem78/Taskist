import 'package:Taskist/models/task_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'filtered_high_state.dart';

class FilteredHighCubit extends Cubit<FilteredHighState> {
  FilteredHighCubit() : super(FilteredHighInitial()) {
    getFirestoreTasks();
  }
  Future<void> getFirestoreTasks() async {
    emit(FilteredHighLoading());
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
          FilteredHighEmpty(message: "No tasks of this priority available"),
        );
      } else {
        emit(FilteredHighLoaded(tasks));
      }
      return tasks;
    } catch (e) {
      emit(
        FilteredHighFailure(message: "Failed to retrieve tasks!"),
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
        emit(FilteredHighRemoveSuccess("Removed task"));
      },
    );
  }
}
