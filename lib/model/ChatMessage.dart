// ignore: file_names
import 'package:mycounter54/model/loginuser.dart';


class ChatMessage {
  int id;
  String messageContent;
  String messageType;
  int senderID;
  int receiverID;
  // ignore: non_constant_identifier_names
  String CheckDate;
  // ignore: non_constant_identifier_names
  String created_at;

  ChatMessage(
      {required this.id,
      required this.messageContent,
      required this.messageType,
      required this.senderID,
      required this.receiverID,
      // ignore: non_constant_identifier_names
      required this.CheckDate,
      // ignore: non_constant_identifier_names
      required this.created_at});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    //print(json);
    return ChatMessage(
      id: json['id'],
      messageContent: json['messageContent'],
      messageType: loginUser!.userid == json["senderID"]
          ? "sender"
          : loginUser!.userid == json["receiverID"]
              ? "receiver"
              : "unknown",
      senderID: json['senderID'],
      receiverID: json['receiverID'],
      CheckDate: json['CheckDate'],
      created_at: json['created_at'],
    );
  }
}

List<ChatMessage> messages = [
  ChatMessage(
      id: 1,
      messageContent: "Hello, Will",
      messageType: "receiver",
      senderID: 3,
      receiverID: 4,
      CheckDate: '2023-06-30',
      created_at: '2023-06-30'),
  ChatMessage(
      id: 1,
      messageContent: "How have you been?",
      messageType: "receiver",
      senderID: 3,
      receiverID: 4,
      CheckDate: '2023-06-30',
      created_at: '2023-06-30'),
  ChatMessage(
      id: 1,
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender",
      senderID: 4,
      receiverID: 3,
      CheckDate: '2023-06-30',
      created_at: '2023-06-30'),
  ChatMessage(
      id: 1,
      messageContent: "ehhhh, doing OK.",
      messageType: "receiver",
      senderID: 3,
      receiverID: 4,
      CheckDate: '2023-06-30',
      created_at: '2023-06-30'),
  ChatMessage(
      id: 1,
      messageContent: "Is there any thing wrong?",
      messageType: "sender",
      senderID: 1,
      receiverID: 2,
      CheckDate: '2023-06-30',
      created_at: '2023-06-30'),
  ChatMessage(
      id: 1,
      messageContent: "No men just chilling",
      messageType: "receiver",
      senderID: 1,
      receiverID: 2,
      CheckDate: '2023-06-30',
      created_at: '2023-06-30'),
];
