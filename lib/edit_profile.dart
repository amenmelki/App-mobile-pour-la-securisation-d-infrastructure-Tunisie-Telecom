import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:pfe_project/bottom_nav_bar.dart';
import 'package:pfe_project/settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:image/image.dart' as img;
import 'main.dart';

/*
Future<String> getSavedString() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';
  return token;
}

Future<http.Response> getUser(String token) async {
  final String url = 'http://192.168.1.99:8000/api/user';
  final response = await http.get(
    Uri.parse(url),
    headers: {'token': '$token'},
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data);
    return response;
  } else {
    throw Exception('failed to load user');
  }
}*/

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  XFile? _image;
  String? token;
  bool showPassword = false;
  int _selectedIndex = 0;
  List<BottomNavItem> navItems = [
    BottomNavItem(
      icon: Icons.person,
      label: 'Account',
      route: '/user',
    ),
    BottomNavItem(
      icon: Icons.home,
      label: 'Home',
      route: '/dashboard',
    ),
    BottomNavItem(
      icon: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
    BottomNavItem(
      icon: Icons.notifications,
      label: 'Notification',
      route: '/notification',
    ),
  ];
  String? profileImage;

  void _onItemTapped(int index, BuildContext context) {
    // Add BuildContext parameter
    switch (navItems[index].route) {
      case '/dashboard':
        Navigator.pushNamed(context, 'dashboard');
        break;
      case '/user':
        Navigator.pushNamed(context, 'user');
        break;
      case '/settings':
        Navigator.pushNamed(context, 'settings');
        break;
      case '/notification':
        Navigator.pushNamed(context, 'notification');
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> updateUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    print('haw token ye king $token');

    final String url = 'http://192.168.1.99:8000/api/update';
    print('name:$name, email:: $email, pass ::$password');
    final Map<String, dynamic> requestData = {
      'name': name,
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      },
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
    } else {
      throw Exception('Failed to update user data');
    }
  }

  Future<void> getUserData() async {
    final String url = 'http://192.168.1.99:8000/api/user';
    final String? token = await getSavedString();

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      nameController.text = data['name'].toString();
      emailController.text = data['email'].toString();
      String image = data['avatar'];
      setState(() {
        profileImage = image;
      });
      print(nameController.text);
      print(emailController.text);
    } else {
      //throw Exception('Failed to load user data');
    }
  }

  Future<String?> getSavedString() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? stringValue = prefs.getString('token');
    return stringValue;
  }

  Future<String?> sendImage(String image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String url = 'http://10.10.23.177:8000/api/avatar';

    final Map<String, dynamic> requestData = {
      'avatar': image,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      }
      if (response.statusCode == 400) {
        final data = json.decode(response.body);
        print(data);
      }
      if (response.statusCode == 401) {
        final data = json.decode(response.body);
        print(data);
      }
      if (response.statusCode == 403) {
        final data = json.decode(response.body);
        print(data);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    /* final token = await getSavedString();
    //final response = getUser(token);
    //log('response: $response');*/
    String? password =
        passwordController.text.isNotEmpty ? passwordController.text : null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.indigo,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.indigo,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        /*  child: GestureDetector(
          behavior: HitTestBehavior.opaque, // Add this line

          onTap: () async {
            final XFile? image =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                _image = image;
              });
            }
          },*/
        child: ListView(
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(File(_image!.path)),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage('assets/image/user_ok.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          setState(() {
                            _image = image;
                          });
                          List<int> imageBytes = await image!.readAsBytes();

                          List<int> compressedImageBytes =
                              await FlutterImageCompress.compressWithList(
                            Uint8List.fromList(imageBytes),
                            minHeight: 300,
                            minWidth: 300,
                          );

                          String base64Image =
                              base64Encode(compressedImageBytes);
                          print('$base64Image');
                          sendImage(base64Image);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.indigo,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            // define the email variable
            BuildTextField(
                "Full Name", nameController.text, false, nameController),
            BuildTextField(
                "Email", emailController.text, false, emailController),
            BuildTextField("Password", "*******", true, passwordController),
            BuildTextField(
                "Confirm Password", "*******", true, confirmPasswordController),
            /*BuildTextField(
                  "Location", "Tunis", false,passwordController),*/
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(width: 1, color: Colors.black),
                    ),
                    onPressed: () {
                      getUserData();
                      print('ici cest paris :::: $token');
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await updateUser(nameController.text,
                          emailController.text, passwordController.text);

                      print(
                          ' $nameController... $emailController ..$passwordController');
                    } catch (e) {
                      print(e);
                      // Show an error message to the user.
                    }
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        iconSize: 30,
        selectedItemColor: Colors.black38,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          _onItemTapped(index, context);
        },
        items: navItems
            .map(
              (navItem) => BottomNavigationBarItem(
                icon: Icon(navItem.icon),
                label: navItem.label,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget BuildTextField(
      String labelText,
      String placehoalder,
      bool isPasswordTextField,
      TextEditingController controller /*,
      String? defaultValue*/
      ) {
    // controller.text = defaultValue ?? '';
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placehoalder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
