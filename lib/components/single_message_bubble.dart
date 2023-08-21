import 'package:flutter/material.dart';


class SingleMessageBubble extends StatelessWidget {

  final String sender;
  final String text;
  final String displayName;
  final bool isMe;
  final String time;

  const SingleMessageBubble({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
    required this.time,
    required this.displayName,
  });

  Column getStyledBubble(bool selfMessage) {
    if (isMe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$displayName',
            // 'Temp Name',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Row(
            children: [
              Text(
                '$sender',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: 10.0,),
              Text(
                '$time',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
          Material(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                '$text',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                '$text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: getStyledBubble(isMe),
    );
  }
}
