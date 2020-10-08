import 'dart:collection';

import 'package:Taskist/data_providers/data_provider.dart';
import 'package:Taskist/models/task_predicate_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineDataProvider implements DataProvider {
  final String _path;
  OnlineDataProvider(String path) : _path = path;

  Future<List<Map<String, dynamic>>> fetch() async {
    var _collection = await FirebaseFirestore.instance.collection(_path).get();
    var _docs = _collection.docs;
    var _internalList = List<Map<String, dynamic>>();
    _docs.forEach(
      (element) {
        var mp = element.data();
        _internalList.add(mp);
      },
    );
    return UnmodifiableListView(_internalList);
  }

  Future<void> remove(String id) async {
    await FirebaseFirestore.instance.collection(_path).doc(id).delete();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchWithPredicate(
    TaskPriorityPredicate predicate,
  ) async {
    var _collection = await FirebaseFirestore.instance
        .collection(_path)
        .where('predicate', isEqualTo: predicate.toString())
        .get();
    var _docs = _collection.docs;
    var _internalList = List<Map<String, dynamic>>();
    _docs.forEach(
      (element) {
        var mp = element.data();
        _internalList.add(mp);
      },
    );
    return UnmodifiableListView(_internalList);
  }

  @override
  Future<void> add(Map<String, dynamic> model) async {
    await FirebaseFirestore.instance
        .collection(_path)
        .doc(model['taskId'])
        .set(model);
  }
}
