//Уг класс нь нууц үгээ мартсан хэрэглэгчийн бүртгэлийг баталгаажуулах боломжийг олгоно.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/screens/login_screens/login_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  final String userInput;
  ForgetPasswordPage({required this.userInput});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordPage> {
  bool visibilityText = true;
  bool visibilityReText = true;
  TextEditingController forgetpasswordController = TextEditingController();
  TextEditingController re_forgetpasswordController = TextEditingController();

  Widget changePasswordButton() {
    return InkWell(
      onTap: () async {
        String newPassword = forgetpasswordController.text;
        String reEnteredPassword = re_forgetpasswordController.text;
        if (newPassword.isEmpty || reEnteredPassword.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password fields cannot be empty')),
          );
          return;
        }
        if (newPassword != reEnteredPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Passwords do not match')),
          );
          return;
        }

        try {
          User? user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            await user.updatePassword(newPassword);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password changed successfully')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else {
            await FirebaseAuth.instance.sendPasswordResetEmail(
              email: widget.userInput,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Password reset email sent. Check your email to reset your password.',
                ),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
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
          'Change Password',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 120,
            ),
            SizedBox(height: 20),
            Text(
              'Forget Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please enter New Password',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Container(
              width: 389,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: visibilityText,
                controller: forgetpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      visibilityText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            Container(
              width: 389,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: visibilityReText,
                controller: re_forgetpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Re-Enter Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      visibilityReText
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: toggleRePasswordVisibility,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            changePasswordButton(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Text('Back to'),
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
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      visibilityText = !visibilityText;
    });
  }

  void toggleRePasswordVisibility() {
    setState(() {
      visibilityReText = !visibilityReText;
    });
  }
}
