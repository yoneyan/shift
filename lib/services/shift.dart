import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shift/services/auth.dart';

class ShiftService {
  final Firestore _firestore = Firestore.instance;
  Auth _auth = new Auth();

  Future<bool> registShiftData(
      Map<String,Map<String, dynamic>> _doc,Map<String, dynamic> _base) async {
    String _id;
    await _auth.currentUser().then((value) => _id = value.uid);

    try {
      bool _result;
      _firestore
          .collection('user')
          .document(_id)
          .collection('shift')
          .document('request')
          .collection(_base['position'])
          .document(_base['year'].toString() + "-" + _base['month'].toString())
          .setData(_doc, merge: true)
          .then((value) => _result = true);
//          .catchError((onError) => {_result = false});
      print('result: OK');
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
