import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_project/models/transaction.dart';
import 'package:hackathon_project/utils/fb_helper.dart';

class FbUserController with FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addTransaction({required TransactionModel transaction}) async {
    try {
      await _firestore
          .collection('Transactions')
          .add(transaction.toMap())
          .then((value) {
        return successResponce;
      });
    } catch (e) {
      return errorResponce;
    }
  }
}
