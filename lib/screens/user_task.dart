// ignore: file_names
import 'package:mycounter54/model/loginuser.dart';
import 'package:mycounter54/model/task.dart';
// import 'package:mycounter54/screens/assignUser.dart';
// import 'package:mycounter54/screens/home.dart';
// import 'package:mycounter54/screens/userhome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class UserTasks extends StatefulWidget {
  const UserTasks({super.key});

  @override
  State<UserTasks> createState() => _UserTasksState();
}

class _UserTasksState extends State<UserTasks> {
  Future<void> _launchUrl() async {
    const String homeLat = "37.3230";
    const String homeLng = "-122.0312";
    // ignore: no_leading_underscores_for_local_identifiers
    final Uri _url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$homeLat,$homeLng");
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  // ignore: prefer_typing_uninitialized_variables
  var valueChoose;
  List listItem = ["On My Way", "Arrived", "Onside", "Completed"];
  final List<TaskModel> _taskList = <TaskModel>[];

  Future updateStatus(taskid) async {
    // print(taskid.toString());
    showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                            // Navigator.of(context).pop();
    var url = Uri.https(
        'driverapi.sokoyoyacomrade.com', '/api/Duties/$taskid');
    var response = await http.put(url, headers: {
      //'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginUser!.token}',
    }, body: {
      'TaskStatus': valueChoose.toString()
    });

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Task Updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // Also possible "TOP" and "CENTER"
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      //taskList = json.decode(response.body);
      // ignore: unused_local_variable
      var parsed = json.decode(response.body);
      // print(parsed);
      // print(parsed);
      // print("--------------------");
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // print("Failed to Send");
    }
  }

  Future<List<TaskModel>?> getTasks() async {
    var url = Uri.https('driverapi.sokoyoyacomrade.com', '/api/Duties');
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

      List<TaskModel> taskList = <TaskModel>[];
      for (var item in parsed) {
        // print(item['Firstname']);
        if (item['Userid'] == loginUser?.userid) {
          taskList.add(TaskModel.fromJson(item));
        }
      }
      // print(taskList);
      // print("--------------------");
      return taskList;
    } else {
      // print("Failed to Send");
    }
    return null;
  }

  @override
  void initState() {
    getTasks().then((value) => {
          setState(() {
            _taskList.addAll(value!);
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("Ati nini");
    // print(_taskList?.length);
    // print("Mzai");
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          "Task Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            // print(_taskList[index].userid.toString() +
            //     'vs' +
            //     loginUser!.userid.toString());

            return SizedBox(
              width: double.infinity,
              height: 250,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                shadowColor: Colors.blue,
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.person),
                        Text("Tripid:\n${_taskList[index].Tripid}"),
                        const Icon(Icons.punch_clock),
                        Text("MemberName: \n${_taskList[index].MemberName}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ignore: prefer_const_constructors
                        Icon(Icons.place),
                        Text("PhoneNumber:\n${_taskList[index].PhoneNumber}"),
                        // ignore: prefer_const_constructors
                        Icon(Icons.task),
                        Text("Level of Service:\n${_taskList[index].LevelofService}"),
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.person),
                        Text("Date of Service:\n${_taskList[index].DateofService}"),
                        const Icon(Icons.punch_clock),
                        
                        Text("Pick Up Time: \n${_taskList[index].PickUpTime}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.place),
                        GestureDetector(
                          onTap: (){
                            _launchUrl();
                          },
                          child: Text("Drop Off Address:\n${_taskList[index].DropOffAddress}"),
                        ),
                        const Icon(Icons.task),
                        Text("Trip Type:\n${_taskList[index].TripType}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.place),
                        Text("DOB:\n${_taskList[index].DOB}"),
                        const Icon(Icons.task),
                        Text("Miles:\n${_taskList[index].Miles}"),
                      ],
                    ),  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                     
                        const Icon(Icons.task),
                        Text("Note:\n${_taskList[index].Note}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton(
                            hint: const Text("Select Task Status"),
                            value: valueChoose,
                            items: listItem
                                .map((valueItem) => DropdownMenuItem(
                                    value: valueItem, child: Text(valueItem)))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                valueChoose = newValue.toString();
                              });
                              // print("-------------");
                              // print(valueChoose);
                            }),
                        ElevatedButton(
                            onPressed:
                                _taskList[index].taskStatus == "Completed"
                                    ? null
                                    : () {
                                        updateStatus(_taskList[index].id);
                                        getTasks().then((value) => {
                                              setState(() {
                                                _taskList.clear();
                                                _taskList.addAll(value!);
                                              })
                                            });
                                      },
                            child: const Text("Update Status"))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.task_alt),
                        Text("Task Status: ${_taskList[index].taskStatus}")
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: _taskList.length),
    );
  }
}
