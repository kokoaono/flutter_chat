import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;


  Future<void> registerNewUser(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> loginUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void logOut() {
    _auth.signOut();
  }
}
