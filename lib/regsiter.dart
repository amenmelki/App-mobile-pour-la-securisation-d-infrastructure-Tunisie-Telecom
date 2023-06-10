import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pfe_project/login.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_project/socket_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> makePostRequest(BuildContext context, String name, String email,
    String password, String address, String phone) async {
  final String url = 'http://10.10.23.177:8000/api/signup';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
/*// Email validation
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegExp.hasMatch(email)) {
    print('Invalid email address');
    return;
  }

  // Password validation
  if (password.length < 8) {
    print('Password must be at least 8 characters');
    return;
  }*/
  final Map<String, dynamic> body = {
    'name': name,
    'email': email,
    'password': password,
    'phone': phone,
    'address': address,
  };
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String? token = responseData['token'];

      // Save the token to the shared preferences for future requests.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token!);
      print('token: $token');

      Navigator.pushNamed(context, 'dataplace');
    } else {
      // ken register mamchech chnowa ysir exemple
      //email wala pass mahomch fl base de donner
    }
  } catch (error) {}
}

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/login11.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 100, top: 0),
              child: Text(
                'Create \n  Account',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.21,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.account_box),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                        suffixIcon: isEmailValid
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.close, color: Colors.red),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        final RegExp emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        setState(() {
                          isEmailValid = emailRegExp.hasMatch(value);
                        });
                      },
                    ),*/
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.indigo,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: isEmailValid && isPasswordValid
                                ? () async {
                                    print(isEmailValid);
                                    print(isPasswordValid);
                                    makePostRequest(
                                        context,
                                        nameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        addressController.text,
                                        phoneController.text);
                                  }
                                : null,
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
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
                              text: "Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: MyLogin(),
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
