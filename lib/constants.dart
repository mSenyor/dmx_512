import 'package:flutter/material.dart';

const String kAppName = 'DMX 512';

const String kMainChatCollectionName = 'mainChat';

const String kLogo = 'images/senyor_logo.png';

const Color kBackgroundColor = Colors.black;
const Color kChatBackgroundColor = Colors.black87;
const Color kBrightTextColor = Colors.white;
const Color kHintTextColor = Colors.grey;
const Color kLogInButtonColor = Colors.purple;
const Color kRegisterButtonColor = Colors.deepPurpleAccent;
const Color kSendButtonColor = kRegisterButtonColor;
const Color kMyMessageBubbleColor = kLogInButtonColor;
const Color kMessageBubbleColor = kRegisterButtonColor;
const Color kDisplayNameColor = kBrightTextColor;

const kSendButtonTextStyle = TextStyle(
  color: kSendButtonColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(
    color: kHintTextColor,
  ),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: kLogInButtonColor,
      width: 2.0,
    ),
  ),
);

const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter Text Here',
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  ),
  hintStyle: TextStyle(
    color: kHintTextColor,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kLogInButtonColor,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kRegisterButtonColor,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);
