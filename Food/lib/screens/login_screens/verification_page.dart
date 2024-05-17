//Уг класс нь verify функцийг хэрэгжүүлдэг болно.
//Энэ нь хэрэглэгчийн шинээрх бүртгэлийг баталгаажуулах боломжийг олгоно.

import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/login_screens/login_page.dart';

class VerificationPage extends StatelessWidget {
  final String phone;

  const VerificationPage({Key? key, required this.phone});

  Widget verifybutton() {
    return InkWell(
      onTap: () {
        if (checkVerificationCodes() == true) {
          showToast("User registered successfully");
          Navigator.push(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          showToast("Please enter all verification codes");
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
          'Verify and Proceed',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  bool checkVerificationCodes() {
    for (int i = 0; i < 4; i++) {
      if (getCodeFromContainer(i).isEmpty) {
        return false;
      }
    }
    return true;
  }

  String getCodeFromContainer(int index) {
    return '';
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
              'Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Verification code is sent to $phone',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSquareContainer(),
                buildSquareContainer(),
                buildSquareContainer(),
                buildSquareContainer(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            verifybutton(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Text('Did not have recieve code?'),
                TextButton(
                  child: const Text(
                    'Resend',
                    style: TextStyle(fontSize: 15, color: Colors.orange),
                  ),
                  onPressed: () {},
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSquareContainer() {
    return Container(
      width: 90,
      height: 109,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 35),
            counterText: '',
            fillColor: Colors.orange,
          ),
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
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
