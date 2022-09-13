import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hackathon_project/firebase/fb_transactions_controller.dart';
import 'package:hackathon_project/models/complaint.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/utils/fb_helper.dart';

class ComplaintGetxController extends GetxController with FirebaseHelper {
  Rx<ComplaintModel> complaint = ComplaintModel().obs;
  RxBool isLoading = false.obs;

  final FbUserController _controller = FbUserController();

  static ComplaintGetxController get to => Get.find<ComplaintGetxController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  // getComplaints() async {
  //   isLoading.value = true;
  //   try {
  //     await _firestore
  //         .collection('Complaints')
  //         .get()
  //         .then((value) {
  //       complaint.value = UserModel.fromMap(value.docs[0].data());
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   isLoading.value = false;
  // }

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
