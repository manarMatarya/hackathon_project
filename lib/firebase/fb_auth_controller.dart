import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/models/user.dart';
import 'package:hackathon_project/prefs/shared_pref_controller.dart';
import 'package:hackathon_project/utils/fb_helper.dart';

class FbAuthController with FirebaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseStorage _storage = FirebaseStorage.instance;
  UserModel userModel = UserModel();

  //LOGIN
  Future<FbResponse> signIn({
    required String id,
    required String password,
  }) async {
    try {
      // userModel = await getCurrentUser(id);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: id,
        password: password,
      );
      bool verified = userCredential.user!.emailVerified;
      if (!verified) {
        await userCredential.user!.sendEmailVerification();
      }
      return FbResponse(
          verified ? 'Logged in Successfully' : 'Verify your Email', verified);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? '', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }

  Future<FbResponse> createAccount(
      {required UserModel user, required String image}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      await userCredential.user!.sendEmailVerification();
      user.image = image;
      saveUserData(user);
      //SharedPrefController().save(user: user);

      return FbResponse('Registered successfully, verify email', true);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? '', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Future<FbResponse> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return FbResponse('Reset email sent successfully', true);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? '', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }

  Future<FbResponse> saveUserData(UserModel user, {image}) async {
    user.image = image;
    return await _firestore
        .collection('Users')
        .doc(user.id)
        .set(user.toMap())
        .then((value) => successResponce)
        .catchError((error) => errorResponce);
  }

  Future<FbResponse> deldete(String id) async {
    return await _firestore
        .collection('Users')
        .doc(id)
        .delete()
        .then((value) => successResponce)
        .catchError((error) => errorResponce);
  }
}
