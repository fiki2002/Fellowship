import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userCollection = "users";

class FirebaseHelper {
  /// -------- AUTHENTICATION --------- ///
  FirebaseAuth get auth => FirebaseAuth.instance;
  String? get currentUserId {
    final String? userId = auth.currentUser?.uid;
    return userId;
  }

  /// ------ FIRESTORE ------ ///
  CollectionReference<Map<String, dynamic>> userCollectionRef() {
    return FirebaseFirestore.instance.collection(userCollection);
  }

  CollectionReference<Map<String, dynamic>> addMemberRef({
    required String adminId,
  }) {
    return userCollectionRef().doc(adminId).collection('members');
  }
}
