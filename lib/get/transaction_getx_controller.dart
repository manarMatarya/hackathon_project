import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hackathon_project/get/user_getx_controller.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/models/transaction.dart';
import 'package:hackathon_project/models/user.dart';
import 'package:hackathon_project/utils/fb_helper.dart';
import 'package:intl/intl.dart';

class TransactionGetxController extends GetxController with FirebaseHelper {
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxList<TransactionModel> latestTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> allTransactions = <TransactionModel>[].obs;

  Rx<TransactionModel> currentTransaction = TransactionModel().obs;
  Rx<UserModel> currentUser = UserModel().obs;
  RxInt tasksCount = 0.obs;
  RxInt executeTasksCount = 0.obs;

  RxBool end = false.obs;
  RxBool isLoading = false.obs;

  static TransactionGetxController get to =>
      Get.find<TransactionGetxController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UserGetxController _userGetxController = UserGetxController.to;

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

  getCustomTransaction(status) async {
    end.value = !(end.value);
    isLoading.value = true;
    try {
      await _firestore
          .collection('Transactions')
          .where('user_branch',
              isEqualTo: _userGetxController.currentUser.value.branchId)
          .where('status', isEqualTo: status)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          transactions.add(TransactionModel.fromMap(value.docs[i].data()));
        }
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }

  getAllTransaction() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Transactions')
          .where('user_branch',
              isEqualTo: _userGetxController.currentUser.value.branchId)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          transactions.add(TransactionModel.fromMap(value.docs[i].data()));
        }
        tasksCount.value = value.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }

  Future<FbResponse> updateTransactionStatus(
      {required TransactionModel transactionModel}) async {
    await _firestore.collection('Users').doc(transactionModel.id).delete();
    return await _firestore
        .collection('Transactions')
        .doc(transactionModel.id)
        .set(transactionModel.toMap())
        .then((value) => successResponce)
        .catchError((e) => errorResponce);
  }

  getTransactionDetails({required String id}) async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Transactions')
          .where('id', isEqualTo: id)
          .get()
          .then((value) async {
        currentTransaction.value =
            TransactionModel.fromMap(value.docs[0].data());

        await _firestore
            .collection('Users')
            .where('id', isEqualTo: currentTransaction.value.userId)
            .get()
            .then((value) {
          currentUser.value = UserModel.fromMap(value.docs[0].data());
        });
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }

  getExTasks({required String status}) async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Transactions')
          .where('user_branch',
              isEqualTo: _userGetxController.currentUser.value.branchId)
          .where('status', isNotEqualTo: 'انتظار')
          .get()
          .then((value) {
        executeTasksCount.value = value.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }
}
