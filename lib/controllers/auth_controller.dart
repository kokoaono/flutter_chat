import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late String? currentUser;
  final RxList<MessageData> messagesList = <MessageData>[].obs;

  final RxString errorMsg = ''.obs;
  final RxString emailExist = ''.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return errorMsg.value = 'Password can not be empty.';
    } else if (password.length < 7) {
      return errorMsg.value = 'Password must be longer than 6 characters';
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
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "email-already-in-use") {
          return emailExist.value = "E-Mail already in use.";
        }
      } else {
        print("Other Error: $e");
      }
    }
    return null;
  }

  Future<void> loginUser(String email, String password) async {
    final logged = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentUser = logged.user?.email;
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
