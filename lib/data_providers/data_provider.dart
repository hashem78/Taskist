import 'package:Taskist/models/task_predicate_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class DataProvider {
  Future<List<Map<String, dynamic>>> fetch();
  Future<List<Map<String, dynamic>>> fetchWithPredicate(
    TaskPriorityPredicate predicate,
  );

  Future<void> remove(String id);
}
