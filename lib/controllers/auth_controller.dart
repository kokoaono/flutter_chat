import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late String? _currentUser;
  final RxList<MessageData> messagesList = <MessageData>[].obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController chatTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final db = FirebaseFirestore.instance;


  void getCurrentUser() {
    /// This is listening to the change of auth state
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        final loggedInUser = user.email;
        print(loggedInUser);
      }
    });
  }

  void messagesStream() async {
    await for (var snapShot in _db.collection('messages').snapshots()) {
      for (var message in snapShot.docs) {
        print(message.data());
      }
    }
  }

  Future<void> addNewMsg(String text) async {
    final message = <String, dynamic>{'text': text, 'sender': _currentUser};
    await _db.collection('messages').add(message);
  }

  Future<void> createNewUser(String email, String password) async {
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
