import 'dart:collection';
import 'package:Taskist/data_providers/data.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:hive/hive.dart';

class LocalDataProvider implements DataProvider {
  final String _name;
  LocalDataProvider(String name) : _name = name;

  @override
  Future<List<Map<String, dynamic>>> fetch() async {
    var _box = await Hive.openBox(_name);
    var _mp = _box.toMap();
    var _internalList = <Map<String, dynamic>>[];
    _mp.values.forEach(
      (element) {
        _internalList.add(Map<String, dynamic>.from(element));
      },
    );
    return UnmodifiableListView(_internalList);
  }

  @override
  Future<void> remove(String id) async {
    var _box = await Hive.openBox(_name);
    await _box.delete(id);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchWithPredicate(
      TaskPriorityPredicate predicate) async {
    var _box = await Hive.openBox(_name);
    var _mp = _box.toMap();
    var _internalList = <Map<String, dynamic>>[];
    _mp.values.forEach(
      (element) {
        if (predicate.toString() == element['predicate'])
          _internalList.add(Map<String, dynamic>.from(element));
      },
    );
    return UnmodifiableListView(_internalList);
  }

  @override
  Future<void> add(Map<String, dynamic> rawModel) async {
    var _box = await Hive.openBox(_name);
    await _box.put(rawModel['taskId'], rawModel);
  }
}
