import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flash_chat/Message.dart';
import 'package:flash_chat/components/MessageBubble.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

class ChatScreen extends StatefulWidget {
  static const String route = "chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  final cloud_firestore.FirebaseFirestore store =
      cloud_firestore.FirebaseFirestore.instance;
  cloud_firestore.CollectionReference messagesCollection;
  final TextEditingController messageController = TextEditingController();
  Stream<cloud_firestore.QuerySnapshot> messagesStream;

  void streamMessages() {
    messagesStream = messagesCollection.orderBy("timestamp").snapshots();
  }

  @override
  void initState() {
    super.initState();
    messagesCollection = store.collection("messages");
    streamMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.popUntil(context, (route) {
                    return route.settings.name == WelcomeScreen.route;
                  });
                });
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<cloud_firestore.QuerySnapshot>(
              stream: messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data.docs.reversed.map((document) {
                        Message message = Message.fromMap(document.data());
                        return MessageBubble(
                          message: message,
                          isSender: message.uid == auth.currentUser.uid,
                        );
                      }).toList(),
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messagesCollection
                          .add(
                        Message(
                          text: messageController.value.text,
                          uid: auth.currentUser.uid,
                          sender: auth.currentUser.email,
                          timestamp:
                              cloud_firestore.FieldValue.serverTimestamp(),
                        ).toMap(),
                      )
                          .then((value) {
                        messageController.clear();
                      }).catchError((error) {
                        print(error);
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
