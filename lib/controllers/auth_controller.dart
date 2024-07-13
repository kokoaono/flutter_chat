import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late String? _currentUser;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController chatTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  void getCurrentUser() {
    /// This is listening to the change of auth state
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        final loggedInUser = user.email;
        print(loggedInUser);
      }
    });
  }

  void getMessages() async {
    final messages = await _db.collection('messages').get().then((event) {
      for (var doc in event.docs) {
        print('${doc.id} => ${doc.data()}');
      }
    });
  }

  Future<void> addNewMsg(String text) async {
    final message = <String, dynamic>{'text': text, 'sender': _currentUser};
    await _db.collection('messages').add(message);
  }

  Future<void> registerNewUser(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> loginUser(String email, String password) async {
    final logged = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _currentUser = logged.user?.email;
    print('I am => ${logged.user?.email}');
  }

  void logOut() {
    _auth.signOut();
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
