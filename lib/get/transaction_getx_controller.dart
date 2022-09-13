import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/models/transaction.dart';
import 'package:hackathon_project/utils/fb_helper.dart';

class TransactionGetxController extends GetxController with FirebaseHelper {
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxList<TransactionModel> latestTransactions = <TransactionModel>[].obs;

  RxBool isLoading = false.obs;

  static TransactionGetxController get to =>
      Get.find<TransactionGetxController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FbResponse> addTransaction(
      {required TransactionModel transaction}) async {
    FbResponse fbResponse = await _firestore
        .collection('Transactions')
        .add(transaction.toMap())
        .then((value) {
      return successResponce;
    }).catchError((e) {
      return errorResponce;
    });

    return fbResponse;
  }

  getTransaction({required String status}) async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Transactions')
          .where('status', isEqualTo: status)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          transactions.add(TransactionModel.fromMap(value.docs[0].data()));
        }
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }

  getLatestTransaction() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Transactions')
      //    .orderBy('date', descending: true)
          .limit(5)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          latestTransactions
              .add(TransactionModel.fromMap(value.docs[0].data()));
        }
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }
}
