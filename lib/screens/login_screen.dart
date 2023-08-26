import 'package:dmx_512/components/rounded_button.dart';
import 'package:dmx_512/constants.dart';
import 'package:dmx_512/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late String email;
  late String password;

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset(kLogo),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Enter Your Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Enter Your Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Hero(
                  tag: 'log_in_button',
                  child: RoundedButton(
                    onPress: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          var user = _auth.currentUser;
                          if (user!.emailVerified) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          } else {
                            await user.sendEmailVerification();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Verify your email'),
                                content: const Text(
                                    'Please log in to your email account and verify it by clicking the link provided'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Got it!');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    },
                                    child: const Text(
                                      'Got it!',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('ERROR!'),
                              content: Text(e.code),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    color: Colors.lightBlueAccent,
                    label: 'Log In',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
