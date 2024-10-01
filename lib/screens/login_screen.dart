import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/controllers/auth_controller.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

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
            SizedBox(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
            const SizedBox(
              height: 48.0,
            ),
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
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter your password.',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Obx(() => Text(
                  controller.errorMsg.value,
                  style: kWarningMessageTextStyle,
                  textAlign: TextAlign.center,
                )),

            ///TODO check the appropriate error display
            Obx(() => Text(
                  controller.loginErrorMsg.value,
                  style: kWarningMessageTextStyle,
                  textAlign: TextAlign.center,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    String? validation = controller.validator(
                      controller.passwordController.text.trim(),
                      controller.emailController.text.trim(),
                    );

                    /// TODO double check the loginUser is doing what is supposed to be doing.
                    String? loginValidation = await controller.loginUser(
                      controller.emailController.text.trim(),
                      controller.passwordController.text.trim(),
                    );
                    if (loginValidation != null || validation != null) {
                      return;
                    } else {
                      Get.dialog(
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                        barrierDismissible: false,
                      );
                      Get.off(() => const ChatScreen());
                      controller.emailController.clear();
                      controller.passwordController.clear();
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text('Log In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
