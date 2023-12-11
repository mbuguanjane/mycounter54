import 'dart:convert';

import 'package:mycounter54/model/clockinout.dart';
import 'package:mycounter54/model/loginuser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserLogs extends StatefulWidget {
  const UserLogs({super.key});

  @override
  State<UserLogs> createState() => _UserLogsState();
}

class _UserLogsState extends State<UserLogs> {
  final List<ClockInOutModel> _clockList = <ClockInOutModel>[];

  Future<List<ClockInOutModel>?> getClockInOut() async {
    var url = Uri.https('driverapi.sokoyoyacomrade.com', '/api/UserLogs');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginUser!.token}',
    }
        // body: {'email': 'mbuguanjane@gmail.com', 'password': '12345678'}
        );

    if (response.statusCode == 200) {
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      //taskList = json.decode(response.body);
      var parsed = json.decode(response.body);
      // print(parsed);

      List<ClockInOutModel> taskList = <ClockInOutModel>[];
      for (var item in parsed) {
        // print(item['Firstname']);
        taskList.add(ClockInOutModel.fromJson(item));
      }
      // print(taskList.length);
      // print("--------------------");
      return taskList;
    } else {
      // print("Failed to Send");
    }
    return null;
  }

  @override
  void initState() {
    
    getClockInOut().then((value) => {
          setState(() {
            _clockList.addAll(value!);
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text(
          "UserLogs Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: _clockList.length,
          itemBuilder: (context, index) {
            return SizedBox(
                width: double.infinity,
                // color: Colors.blue,
                height: 250,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  shadowColor: Colors.blue,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.date_range_sharp),
                          Text("Date: ${_clockList[index].CheckDate}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.person),
                          const Text("User:"),
                          Text(_clockList[index].Name)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.punch_clock_sharp),
                          Text("Time In: ${_clockList[index].TimeIn}"),
                          const Icon(Icons.punch_clock_sharp),
                          Text("Time Out: ${_clockList[index].TimeOut}")
                        ],
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
