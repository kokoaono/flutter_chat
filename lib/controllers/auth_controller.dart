import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? currentUser;
  // late String? currentUser;
  final RxList<MessageData> messagesList = <MessageData>[].obs;

  final RxString errorMsg = ''.obs;
  final RxString emailExistMsg = ''.obs;
  final RxString loginErrorMsg = ''.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  String? validator(String password, String email) {
    emailExistMsg.value = '';
    errorMsg.value = '';
    if (password.isEmpty || email.isEmpty) {
      return errorMsg.value = 'Please add email and password.';
    } else if (password.length <= 5) {
      return errorMsg.value = 'Password must be longer than 5 characters';
    } else if (!email.contains('@') || !email.endsWith('.com')) {
      return errorMsg.value =
          'Please enter a valid email address (must contain "@" and end with ".com").';
    }
    return null;
  }

  void getCurrentUser() {
    /// This is listening to the change of auth state
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        user.email;
      }
    });
  }

  Future<void> addNewMsg(String text) async {
    final message = <String, dynamic>{'text': text, 'sender': currentUser};
    await db.collection('messages').add(message);
  }

  Future<String?> createNewUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        return emailExistMsg.value =
            'The account already exists for that email.';
      } else {
        print("Other Error: $e");
      }
    }
    return null;
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      final logged = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = logged.user?.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ///This is not working at moment
        print(loginErrorMsg);
        return loginErrorMsg.value = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return loginErrorMsg.value = 'Wrong password provided for that user.';
      }
    }
    return null;
  }

  void logOut() async {
    await _auth.signOut();
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
