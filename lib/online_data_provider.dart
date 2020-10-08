import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineDataProvider {
  Future<Map<String, dynamic>> fetch(String collectionPath) async {
    var _collection =
        await FirebaseFirestore.instance.collection(collectionPath).get();
    var _docs = _collection.docs;
    var _internalMap = Map<String, dynamic>();
    _docs.forEach(
      (element) {
        var mp = element.data();
        var id = element.id;
        _internalMap[id] = mp.values;
      },
    );
    print(_internalMap);
    return _internalMap;
  }

  Future<void> remove(String collectionPath, String id) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(id)
        .delete();
  }
}
