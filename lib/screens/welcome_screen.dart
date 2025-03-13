import 'package:flutter/material.dart';
import 'package:flutter_chat/controllers/auth_controller.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:flutter_chat/widgets/auth_button.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  child: Image.asset('images/logo.png'),
                ),
                const Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            AuthButtonWidget(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Get.to(() => const LoginScreen());
                  Get.find<AuthController>().clearError();
                },
                child: const Text('Log In')),
            AuthButtonWidget(
                color: Colors.blueAccent,
                onPressed: () {
                  Get.to(() => const RegistrationScreen());
                  Get.find<AuthController>().clearError();
                },
                child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}
