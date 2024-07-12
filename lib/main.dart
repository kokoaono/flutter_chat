import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/controllers/auth_controller.dart';
import 'package:flutter_chat/firebase_options.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:get/get.dart';

void main() async {
  ///initialize Firebase using the DefaultFirebaseOptions object exported by the configuration file
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => const WelcomeScreen()),
      //   GetPage(name: '/chatScreen', page: () => const ChatScreen()),
      // ],
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
