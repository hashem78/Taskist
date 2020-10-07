import 'package:Taskist/models/task_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'filtered_low_state.dart';

class FilteredLowCubit extends Cubit<FilteredLowState> {
  FilteredLowCubit() : super(FilteredLowInitial()) {
    getFirestoreTasks();
  }
  Future<void> getFirestoreTasks() async {
    emit(FilteredLowLoading());
    try {
      var collection = await FirebaseFirestore.instance
          .collection('tasks')
          .where('predicate', isEqualTo: 'low')
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
          FilteredLowEmpty(message: "No tasks of this priority available"),
        );
      } else {
        emit(FilteredLowLoaded(tasks));
      }
      return tasks;
    } catch (e) {
      emit(
        FilteredLowFailure(message: "Failed to retrieve tasks!"),
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
        emit(FilteredLowRemoveSuccess("Removed task"));
      },
    );
  }
}
