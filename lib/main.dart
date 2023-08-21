import 'package:dmx_512/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dmx_512/screens/welcome_screen.dart';
import 'package:dmx_512/screens/login_screen.dart';
import 'package:dmx_512/screens/registration_screen.dart';
import 'package:dmx_512/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Dmx512());
}

class Dmx512 extends StatelessWidget {
  const Dmx512({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //     textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black54))),
      // home: WelcomeScreen(),

      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
