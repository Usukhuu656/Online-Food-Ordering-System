import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/firebase/app_state.dart';
import 'package:shop_app/screens/login_screens/forget_password_page.dart';
import 'package:shop_app/screens/login_screens/login_page.dart';

class VerificationForgetPasswordPage extends StatefulWidget {
  const VerificationForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<VerificationForgetPasswordPage> createState() =>
      _VerificationForgetPasswordState();
}

class _VerificationForgetPasswordState
    extends State<VerificationForgetPasswordPage> {
  TextEditingController forgetController = TextEditingController();

  Widget verifyButton() {
    return InkWell(
      onTap: () async {
        String input = forgetController.text;
        if (input.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter an email or phone number')),
          );
          return;
        }

        if (isEmail(input)) {
          try {
            final appState =
                Provider.of<ApplicationState>(context, listen: false);
            await appState.signInWithEmail(
              email: input,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgetPasswordPage(userInput: input),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
          }
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
            )
          ],
          color: Color.fromARGB(255, 203, 133, 59),
        ),
        child: Text(
          'Send verify code',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  bool isEmail(String input) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(input);
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
              'Enter your Email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Container(
              width: 389,
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: forgetController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter email',
                  hintText:
                      forgetController.text.isEmpty ? 'example@gmail.com' : '',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            verifyButton(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 389,
              child: Text(
                '---------------------------------------- OR -----------------------------------------',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            loginGoogleButton(),
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
}
