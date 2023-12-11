
import 'package:mycounter54/model/loginuser.dart';
import 'package:mycounter54/screens/home.dart';
import 'package:mycounter54/screens/userhome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailempty = false, passwordempty = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future createUser(context) async {
    if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
       showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                            // Navigator.of(context).pop();
      var url = Uri.https('driverapi.sokoyoyacomrade.com', '/api/login');
      // print(emailcontroller.text);
      var response = await http.post(url, body: {
        'email': emailcontroller.text,
        'password': passwordcontroller.text
      });

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Login success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM, // Also possible "TOP" and "CENTER"
            backgroundColor: Colors.grey,
            textColor: Colors.white);
        final Map parsed = json.decode(response.body);

        try {
          var user = LoginUser.fromJson(parsed);
          loginUser = user;
          // print(user.UserType);
          if (user.UserType == 'User') {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const UserHome()));
          } else if (user.UserType == 'Admin') {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
          // print('User body==>: ${user.userModel.name}');
          // print('User body==>: ${user.token}');
          // print('User body==>: ${user.userid}');
        } catch (e) {
          // print(e);
        }
      } else {
        Navigator.of(context).pop();
        // print("Failed to Login");
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM, // Also possible "TOP" and "CENTER"
            backgroundColor: Colors.grey,
            textColor: Colors.white);
      }
      setState(() {
        if (emailcontroller.text.isEmpty) {
          emailempty = true;
        } else {
          emailempty = false;
        }
        if (passwordcontroller.text.isEmpty) {
          passwordempty = true;
        } else {
          passwordempty = false;
        }
      });
    } else {
      setState(() {
        if (emailcontroller.text.isEmpty) {
          emailempty = true;
        } else {
          emailempty = false;
        }
        if (passwordcontroller.text.isEmpty) {
          passwordempty = true;
        } else {
          passwordempty = false;
        }
      });
      Fluttertoast.showToast(
          msg: "Empty  Fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // Also possible "TOP" and "CENTER"
          backgroundColor: Colors.grey,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SizedBox(
          width: 350,
          height: 350,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            shadowColor: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          errorText: emailempty ? "Email required" : null,
                          border: const OutlineInputBorder(),
                          label: const Text("Email"),
                          hintText: "name@gmail.com",
                          prefixIcon: const Icon(Icons.mail))),
                  TextField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText: passwordempty ? "Password required" : null,
                          border: const OutlineInputBorder(),
                          label: const Text("Password"),
                          prefixIcon: const Icon(Icons.security_sharp))),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                       

                        createUser(context);
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const Text(
                        "Login",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
