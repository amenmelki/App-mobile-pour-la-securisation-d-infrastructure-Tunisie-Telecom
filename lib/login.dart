import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pfe_project/regsiter.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_project/socket_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:pfe_project/dataplace.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

Future<void> makePostRequest(
    BuildContext context, String email, String password) async {
  final String url = 'http://10.10.23.177:8000/api/login';
  String? token;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> body = {'email': email, 'password': password};
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      token = responseData['token'];

      // Save the token to the shared preferences for future requests.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token!);

      //headers['Authorization'] = 'Bearer $token';

      Navigator.pushNamed(context, 'home');

      // Return the token.
    } else if (response.statusCode == 401) {
      throw Exception('Invalid email or password');
    }
  } on Exception catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Failed to Login\nInvalid email or password'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordTouched = false;
  bool isEmailTouched = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/login11.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 120, right: 40, left: 65),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Please login to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Add the GIF here
                  /*   Image.asset(
                    'assets/image/login_back.png',
                    width: 400, // set the width and height of the image
                    height: 300,
                  ),*/
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                        errorText: isEmailTouched && !isEmailValid
                            ? 'Please entre a valid email'
                            : null,
                        suffixIcon:
                            (emailController.text.isEmpty || !isEmailValid)
                                ? Icon(Icons.close, color: Colors.red)
                                : Icon(Icons.check, color: Colors.green),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.email),
                      ),
                      onChanged: (value) {
                        final RegExp emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        setState(() {
                          isEmailValid = value.isEmpty
                              ? false
                              : emailRegExp.hasMatch(value);
                        });
                      },
                      onTap: () {
                        setState(() {
                          isEmailTouched = true;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                        errorText: isPasswordTouched && !isPasswordValid
                            ? 'Password must be at least 8 characters'
                            : null,
                        suffixIcon: isPasswordValid
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.close, color: Colors.red),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isPasswordValid = value.length >= 7;
                        });
                      },
                      onTap: () {
                        setState(() {
                          isPasswordTouched = true;
                        });
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.indigo,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: isEmailValid && isPasswordValid
                                ? () async {
                                    print(isEmailValid);
                                    print(isPasswordValid);
                                    makePostRequest(
                                      context,
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                : null,
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "Signup",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: MyRegister(),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ])),
                          /* TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'login');
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
