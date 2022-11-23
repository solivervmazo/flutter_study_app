import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_app/firebase/question_papers_collection_reference.dart';
import 'package:flutter_study_app/widgets/dialog_widget.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  late FirebaseAuth _firebaseAuth;
  final Rxn<User> _user = Rxn<User>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late Stream<User?> _authStateChanges;
  @override
  void onReady() {
    initAuth();
    _user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void initAuth() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    _firebaseAuth = FirebaseAuth.instance;
    _authStateChanges = _firebaseAuth.authStateChanges();
    _authStateChanges.listen(
      (User? user) {
        _user.value = user;
      },
    );
    navigateToIntroduction();
  }

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: authAccount.idToken,
          accessToken: authAccount.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        await saveUser(account);
        Get.offAllNamed("/home");
      } else {}
    } catch (err) {
      print("ERROR: $err");
    }
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilePic": account.photoUrl,
    });
  }

  void showLoginAlertDialog() {
    Get.dialog(
      DialogWidget.questionStartDialog(
        onTap: () {
          Get.back();
          Get.toNamed("/signin");
        },
      ),
    );
  }

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _firebaseAuth.signOut();
  }
}
