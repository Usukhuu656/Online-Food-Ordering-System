//Уг класс нь шинэ хэрэглэгчдийг бүртгэх registerUser функцийг хэрэгжүүлдэг болно.
//Энэ нь шинээр бүртгүүлэхийг хүссэн хэрэглэгчийн мэдээллийг авч тухайн хэрэглэгчийг баталгаажуулснаар өгөгдлийн санд бүртгэх боломжийг олгоно.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/login_screens/verification_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscure = true;
  bool obscureRe = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Widget signButton() {
    return InkWell(
      onTap: () {
        if (validateFields()) {
          registerUser();
          verificationUser();
        }
      },
      child: Container(
        width: 389,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(255, 106, 106, 23).withAlpha(100),
              offset: Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
          color: Color.fromARGB(255, 203, 133, 59),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  bool validateFields() {
    if (nameController.text.isEmpty) {
      showToast("Name field is required");
      return false;
    }
    if (gmailController.text.isEmpty) {
      showToast("Email field is required");
      return false;
    }
    if (phoneController.text.isEmpty) {
      showToast("Phone Number field is required");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showToast("Password field is required");
      return false;
    }
    if (rePasswordController.text.isEmpty) {
      showToast("Re-enter Password field is required");
      return false;
    }
    if (passwordController.text != rePasswordController.text) {
      showToast("Passwords do not match");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', height: 13),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 28,
            bottom: 32,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Enter Your Information Here',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Container(
                  width: 389,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  width: 389,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: gmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: gmailController.text.isEmpty
                          ? 'example@gmail.com'
                          : '',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Container(
                  width: 389,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      hintText:
                          phoneController.text.isEmpty ? '+976 99****99' : '',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                Container(
                  width: 389,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: obscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: togglePassword,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 389,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: obscureRe,
                    controller: rePasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Re-Enter Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureRe ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: toggleRePassword,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'By signing up you accept our terms of use and\n',
                    ),
                    TextButton(
                      child: const Text(
                        'Privacy policy',
                        style: TextStyle(fontSize: 15, color: Colors.orange),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                signButton(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const Text('Already have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 15, color: Colors.orange),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print("Firebase initialization error: $e");
    }

    String password = passwordController.text;
    String gmail = gmailController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: gmail,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        user.updateDisplayName(nameController.text);
        showToast("Registration Successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        showToast("User creation failed: User is null");
      }
    } catch (e) {
      showToast("User creation failed: $e");
    }
  }

  void togglePassword() {
    setState(() {
      obscure = !obscure;
    });
  }

  void toggleRePassword() {
    setState(() {
      obscureRe = !obscureRe;
    });
  }

  void verificationUser() async {
    String phoneNumber = phoneController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationPage(phone: phoneNumber),
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
