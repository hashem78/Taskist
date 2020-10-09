import 'package:Taskist/models/task_predicate.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class DataProvider {
  Future<List<Map<String, dynamic>>> fetch();
  Future<List<Map<String, dynamic>>> fetchWithPredicate(
    TaskPriorityPredicate predicate,
  );
  Future<void> add(Map<String, dynamic> model);
  Future<void> remove(String id);
}
