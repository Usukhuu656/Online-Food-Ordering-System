//Энэ класс нь Login функцийг хэрэгжүүлдэг болно.
//Энэ класс хэрэглэгчдэд өөрийн бүртгэлтэй э-майл хаяг болон нууц үгээ хийж сайт руу нэвтрэх боломжийг олгоно.

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/firebase/app_state.dart';
import 'package:shop_app/screens/login_screens/verification_forget_password_page.dart';
import 'package:shop_app/screens/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String enteredUserName = gmailController.text;
    String enteredPassword = passwordController.text;

    try {
      final appState = Provider.of<ApplicationState>(context, listen: false);
      await appState.signInWithEmailAndPassword(
        email: enteredUserName,
        password: enteredPassword,
      );

      showToast("Login Successful");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(loggedInCustomer: enteredUserName),
        ),
      );
    } catch (e) {
      showToast("Error during login: $e");
    }
  }

  Widget submitButton() {
    return InkWell(
      onTap: login,
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
            )
          ],
          color: Color.fromARGB(255, 203, 133, 59),
        ),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 2, 1, 0)),
        ),
      ),
    );
  }

  Widget loginGoogleButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 389,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xff4285f4).withAlpha(100),
              offset: Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/google_logo.png',
              height: 22.0,
            ),
            SizedBox(width: 8),
            Text(
              'Login with Google',
              style: TextStyle(fontSize: 15, color: Color(0xff4285f4)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 100,
            bottom: 32,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: 120,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
                loginGoogleButton(),
                SizedBox(height: 20),
                Container(
                  width: 389,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    '----------------------------------------- OR -----------------------------------------',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: obscureText,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 25),
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Remember me',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VerificationForgetPasswordPage()),
                          );
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                submitButton(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const Text('Does not have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20, color: Colors.orange),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                    )
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

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
