import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hackathon_project/firebase/fb_auth_controller.dart';
import 'package:hackathon_project/models/user.dart';

class UserGetxController extends GetxController {
  Rx<UserModel> currentUser = UserModel().obs;
  RxBool isLoading = false.obs;

  static UserGetxController get to => Get.find<UserGetxController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  getCurrentUser() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('Users')
          .where('email', isEqualTo: FbAuthController().currentUser!.email)
          .get()
          .then((value) {
        currentUser.value = UserModel.fromMap(value.docs[0].data());
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }
}
