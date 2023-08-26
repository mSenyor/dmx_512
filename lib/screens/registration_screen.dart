import 'package:dmx_512/constants.dart';
import 'package:dmx_512/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:dmx_512/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late String nickname;
  late String email;
  late String password;

  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset(
                        kLogo,
                      ),
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
                    // email = value;
                    nickname = value;
                  },
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Choose a Nickname to display in chat'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Nickname';
                    } else {
                      return null;
                    }
                  },
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
                  height: 24.0,
                ),
                Hero(
                  tag: 'register_button',
                  child: RoundedButton(
                    onPress: () async {
                      if (_registerFormKey.currentState!.validate()) {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          registerUser(_auth.currentUser, nickname);
                          final currentUserLogged = _auth.currentUser;
                          if (currentUserLogged != null) {
                            // currentUserLogged.emailVerified
                            if (currentUserLogged.emailVerified) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            } else {
                              var user = _auth.currentUser;
                              await user?.sendEmailVerification();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                  title: const Text(
                                      'Registration completed successfully!'),
                                  content: const Text(
                                      'You will be sent a verification link to the email address you\'ve provided within a few minutes. Once your complete the verification, you can log in to the chat through the Log In screen'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                        Navigator.pushNamed(context, LoginScreen.id);
                                      },
                                      child: const Text(
                                        'OK',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          if(e.code == 'email-already-in-use'){
                            Navigator.pushNamed(context, LoginScreen.id);
                            showSpinner = false;
                          }
                          else{
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
                      }
                    },
                    color: Colors.blueAccent,
                    label: 'Register',
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

User? registerUser(User? user, String nickname){
  user?.updateDisplayName(nickname);
  // user.updatePhoneNumber('phoneCredential' as PhoneAuthCredential);
  // user.updatePhotoURL('photoURL');
  return user;
}