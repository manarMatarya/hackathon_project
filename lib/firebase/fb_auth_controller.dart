import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon_project/models/fb_response.dart';

class FbAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //LOGIN
  Future<FbResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
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

  Future<FbResponse> createAccount({
    required String email,
    required String password,
    required String name,
    required String mobile,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();

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
}
