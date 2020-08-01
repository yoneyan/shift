import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shift/services/auth.dart';

class Base {
  final Firestore _firestore = Firestore.instance;
  Auth _auth = new Auth();

  Future<List<String>> getPositionData(String date) async {
    List<String> _data;
    try {
      await _firestore
          .collection('base')
          .document('position')
          .get()
          .then((doc) => {
                for (int i = 0; i < doc.data.length; i++)
                  {
                    _data.add('value'),
                    _data.add(doc.data['$i']),
                  },
              });
    } catch (err) {
      print("Error: $err");
      _data = null;
    }
    print(_data);
    return _data;
  }

  Future<List<String>> getShiftData(String id) async {
    List<String> _data = [];
    try {
      await _firestore
          .collection('base')
          .document('shift')
          .get()
          .then((doc) => {
                doc.data.forEach((key, value) {
                  if (id == key) {
                    if (value['type'] == 0) {
                      _data.add('0');
                    } else if (0 < value['type'] || value['type'] < 5) {
                      _data.add(value['type'].toString());
                      print(value['data']);
                      for (int i = 0; i < value['data'].length; i++) {
                        _data.add(value['data'][i].toString());
                      }
                    } else {
                      _data = null;
                    }
                  }
                }),
              });
    } catch (err) {
      print("Error: $err");
      _data = null;
    }
    print(_data);
    return _data;
  }

  Future<Map<String, String>> getUser() async {
    Map<String, String> _data = new Map<String, String>();
    String _id;
    await _auth.currentUser().then((value) => _id = value.uid);
    try {
      await _firestore.collection('user').document(_id).get().then((doc) => {
            _data['position'] = doc.data['position'].toString(),
            _data['name'] = doc.data['name'].toString(),
            _data['isActive'] = doc.data['isActive'].toString(),
            _data['id'] = doc.data['id'].toString(),
          });
      print("MAP:$_data");
      return _data;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<Map<String, Map<String, dynamic>>> getShiftRegistrationData() async {
    Map<String, Map<String, dynamic>> _data =
        new Map<String, Map<String, dynamic>>();
    String _id;
    await _auth.currentUser().then((value) => _id = value.uid);

    //500: time 501:difference
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .document(_id)
          .collection('shift')
          .document('request')
          .collection('0')
          .getDocuments();
      for (int i = 0; i < querySnapshot.documents.length; i++) {
        var a = querySnapshot.documents[i];
        _data[a.documentID.toString()] = a.data;
      }
      print(_data);
      return _data;
    } catch (err) {
      print('NULL');
      print(err);
      return null;
    }
  }
}
