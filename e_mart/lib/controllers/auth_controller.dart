import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  //text controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Login Method
  Future<UserCredential?> loginMethod({context}) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      // Handle specific error codes
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = "Invalid Credentials. Try again";
          break;
        case 'user-disabled':
          errorMessage = "This user account has been disabled.";
          break;
        case 'channel-error':
          if (emailController.text.isEmpty && passwordController.text.isEmpty) {
            errorMessage = "Credentials Missing.";
          } else if (emailController.text.isEmpty) {
            errorMessage = "Email is missing.";
          } else if (passwordController.text.isEmpty) {
            errorMessage = "Password is missing.";
          } else {
            errorMessage = "Unknown Error";
          }
          break;
        default:
          errorMessage = "Login failed. Please try again.";
      }
      VxToast.show(context, msg: errorMessage);
      return null;
    } catch (e) {
      // Handle any other exceptions
      VxToast.show(context,
          msg: "An unexpected error occurred. Please try again.");
      return null;
    }
  }

  Future<UserCredential?> signupMethod({context, email, password}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      // Handle specific error codes
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              "The email address is already in use by another account.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email/password accounts are not enabled.";
          break;
        case 'weak-password':
          errorMessage =
              "The password is too weak. Please use a stronger password.";
          break;
        default:
          errorMessage = e.message ?? "Signup failed. Please try again.";
      }
      VxToast.show(context, msg: errorMessage);
      return null;
    } catch (e) {
      // Handle any other exceptions
      VxToast.show(context,
          msg: "An unexpected error occurred. Please try again.");
      return null;
    }
  }

  // Cloud Firestore: Store User Data
  Future<void> storeUserData(
      {required String name,
      required String password,
      required String email}) async {
    try {
      String uid = auth.currentUser!.uid; // Ensure user is signed in
      DocumentReference store = firestore.collection(usersCollection).doc(uid);
      await store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': '',
        'id': currentUser!.uid,
      });
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  // Sign Out Method
  Future<void> signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
