import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

class Message {
  final String text;
  final String sender;
  final String uid;
  final timestamp;
  Message({
    this.text,
    this.sender,
    this.uid,
    this.timestamp,
  });

  Message copyWith({
    String text,
    String sender,
    String uid,
    timestamp,
  }) {
    return Message(
      text: text ?? this.text,
      sender: sender ?? this.sender,
      uid: uid ?? this.uid,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'uid': uid,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      text: map['text'],
      sender: map['sender'],
      uid: map['uid'],
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(text: $text, sender: $sender, uid: $uid, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Message &&
        o.text == text &&
        o.sender == sender &&
        o.uid == uid &&
        o.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return text.hashCode ^ sender.hashCode ^ uid.hashCode ^ timestamp.hashCode;
  }
}
