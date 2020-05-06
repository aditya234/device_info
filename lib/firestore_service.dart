import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  String COLLECTION = "devices";
  static final databaseReference = Firestore.instance;

  void createRecord(Map<String, String> data) async {
    DocumentReference ref =
        await databaseReference.collection(COLLECTION).add(data);
    print("CREATED DOCUMENT ID - ${ref.documentID}");
  }

  Future<List<Map>> getRecords() async {
    List<Map> responseData = [];
    QuerySnapshot snapshot =
        await databaseReference.collection(COLLECTION).getDocuments();
    snapshot.documents.forEach((doc) {
      responseData.add(doc.data as Map);
    });
    return responseData;
  }
}
