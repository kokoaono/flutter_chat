import 'package:flutter/material.dart';
import 'package:flutter_chat/controllers/auth_controller.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/widgets/auth_button.dart';
import 'package:get/get.dart';

import '../constants.dart';

class RegistrationScreen extends GetView<AuthController> {
  const RegistrationScreen({super.key});

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
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Obx(
              () => Text(
                controller.emailExistMsg.value,
                style: kWarningMessageTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            Obx(() => Text(
                  controller.errorMsg.value,
                  style: kWarningMessageTextStyle,
                  textAlign: TextAlign.center,
                )),
            AuthButtonWidget(
                color: Colors.blueAccent,
                onPressed: () async {
                  String? validation = controller.validator(
                    controller.passwordController.text.trim(),
                    controller.emailController.text.trim(),
                  );
                  String? emailValidation = await controller.createNewUser(
                    controller.emailController.text.trim(),
                    controller.passwordController.text.trim(),
                  );
                  if (validation != null || emailValidation != null) {
                    return;
                  } else {
                    Get.dialog(
                      const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );
                    Get.offAll(() => const ChatScreen());
                    controller.emailController.clear();
                    controller.passwordController.clear();
                  }
                },
                child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}
