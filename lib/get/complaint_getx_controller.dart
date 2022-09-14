import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hackathon_project/firebase/fb_transactions_controller.dart';
import 'package:hackathon_project/models/complaint.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/utils/fb_helper.dart';

class ComplaintGetxController extends GetxController with FirebaseHelper {
  RxList<ComplaintModel> complaint = <ComplaintModel>[].obs;
  RxList<ComplaintModel> allComplaint = <ComplaintModel>[].obs;

  var complaintCount = 0.obs;
  RxList<ComplaintModel> suggestion = <ComplaintModel>[].obs;
  var suggestionCount = 0.obs;
  RxBool isLoading = false.obs;

  final FbUserController _controller = FbUserController();

  static ComplaintGetxController get to => Get.find<ComplaintGetxController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getAllComplaints() async {
    isLoading.value = true;
    try {
      await _firestore.collection('Complaints').get().then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          allComplaint.add(ComplaintModel.fromMap(value.docs[0].data()));
        }
        complaintCount.value = value.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }

  getComplaints() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Complaints')
          .where('isComplaint', isEqualTo: true)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          complaint.add(ComplaintModel.fromMap(value.docs[0].data()));
        }
        complaintCount.value = value.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }

  getSuggestions() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Complaints')
          .where('isComplaint', isEqualTo: false)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          suggestion.add(ComplaintModel.fromMap(value.docs[0].data()));
        }
        suggestionCount.value = value.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }

  Future<FbResponse> addComplaint({required ComplaintModel complaint}) async {
    FbResponse fbResponse = await _firestore
        .collection('Complaints')
        .add(complaint.toMap())
        .then((value) {
      return successResponce;
    }).catchError((e) {
      return errorResponce;
    });

    return fbResponse;
  }
}
