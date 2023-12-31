// ignore: file_names
import 'package:mycounter54/model/loginuser.dart';
import 'package:mycounter54/model/usermodel.dart';
import 'package:mycounter54/screens/user_chat_detail.dart';
// import 'package:mycounter54/screens/chatDetail.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// import 'dart:io';
// import 'package:flutter/services.dart' show ByteData, rootBundle;
// import 'package:excel/excel.dart';
// import 'package:fast_csv/fast_csv.dart' as _fast_csv;
// import 'package:file_picker/file_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UserChatList extends StatefulWidget {
  const UserChatList({super.key});

  @override
  State<UserChatList> createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  updateChat(receiverid) async {
    //updateChat
    var url = Uri.https('driverapi.sokoyoyacomrade.com',
        '/api/updateChat/$receiverid');
    // ignore: unused_local_variable
    var response = await http.get(url, headers: {
      //'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginUser!.token}',
    }
        // body: {'email': 'mbuguanjane@gmail.com', 'password': '12345678'}
        );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
  }

  final List<UserModel> _userList = <UserModel>[];

  Future<List<UserModel>?> getUsers() async {
    var url = Uri.https('driverapi.sokoyoyacomrade.com', '/api/users');
    var response = await http.get(url, headers: {
      //'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginUser!.token}',
    }
        // body: {'email': 'mbuguanjane@gmail.com', 'password': '12345678'}
        );

    if (response.statusCode == 200) {
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      //userList = json.decode(response.body);
      var parsed = json.decode(response.body);
      // print(parsed);

      List<UserModel> userList = <UserModel>[];
      for (var item in parsed) {
        // print(item['Firstname']);
        if (item["UserType"] == "Admin") {
          if (loginUser!.userid != item['id']) {
            userList.add(UserModel(
              id: item['id'],
              name: item['name'],
              email: item['email'],
              UserType: item['UserType'],
              messageStatus: item['messageStatus'],
            ));
          }
        }
      }
      // print(userList.length);
      // print("--------------------");
      return userList;
    } else {
      // print("Failed to Send");
    }
    return null;
  }

  @override
  void initState() {
    getUsers().then((value) => {
          setState(() {
            _userList.addAll(value!);
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Management",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: _userList[index].id != loginUser!.userid
                  ? () {
                      updateChat(_userList[index].id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserChatDetail(
                                    userReceiver: _userList[index],
                                  )));
                    }
                  : null,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/${_userList[index].id}.jpg"),
                maxRadius: 20,
              ),
              title: Text(_userList[index].name),
              subtitle: const Text("Hello"),
              trailing: _userList[index].messageStatus == "unseen"
                  ? const Column(
                      children: [
                        Text("New message"),
                        Icon(
                          Icons.message_rounded,
                          color: Colors.blue,
                        )
                      ],
                    )
                  : null,
            );
          },
          separatorBuilder: (context, index) => const Divider(color: Colors.blue),
          itemCount: _userList.length),
    );
  }
}
