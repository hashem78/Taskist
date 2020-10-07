import 'package:Taskist/models/task_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'filtered_none_state.dart';

class FilteredNoneCubit extends Cubit<FilteredNoneState> {
  FilteredNoneCubit() : super(FilteredNoneInitial()) {
    getFirestoreTasks();
  }
  Future<void> getFirestoreTasks() async {
    emit(FilteredNoneLoading());
    try {
      var collection = await FirebaseFirestore.instance
          .collection('tasks')
          .where('predicate', isEqualTo: 'no')
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
          FilteredNoneEmpty(message: "No tasks of this priority available"),
        );
      } else {
        emit(FilteredNoneLoaded(tasks));
      }
      return tasks;
    } catch (e) {
      emit(
        FilteredNoneFailure(message: "Failed to retrieve tasks!"),
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
        emit(FilteredNoneRemoveSuccess("Removed task"));
      },
    );
  }
}
