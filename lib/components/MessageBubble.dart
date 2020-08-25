import 'package:flash_chat/Message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isSender;
  const MessageBubble(
      {Key key, @required this.message, @required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: TextStyle(color: Colors.black54, fontSize: 13.0),
          ),
          SizedBox(
            height: 2.0,
          ),
          Material(
            color: isSender ? Colors.lightBlueAccent : Colors.white,
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isSender ? 30.0 : 0.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(isSender ? 0.0 : 30.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isSender ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
