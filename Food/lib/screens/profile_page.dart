import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/login_screens/login_page.dart';

class ProfilePage extends StatefulWidget {
  final String loggedInCustomer;

  ProfilePage({Key? key, required this.loggedInCustomer}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String logincustomer;
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    logincustomer = extractName(widget.loggedInCustomer);
  }

  String extractName(String email) {
    return email.split('@').first;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(builder: (context, provider, child) {
      totalAmount = provider.setTotal();
      return Scaffold(
        appBar: AppBar(
          title: Text('MyProfile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/photo.png'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: $logincustomer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Email: ${widget.loggedInCustomer}'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.yellow[200],
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildExpansionTile('Edit Profile', buildEditProfileContent()),
                  buildExpansionTile('My Orders', buildMyOrdersContent()),
                  buildExpansionTile(
                      'Payment Methods', buildPaymentMethodContent()),
                  buildExpansionTile('My Reviews', buildReviewsContent()),
                  buildExpansionTile('Settings', buildSettingsContent()),
                ],
              ),
              Container(
                color: Colors.yellow[200],
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'General Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildExpansionTile('About Us', buildAboutUsContent()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      signOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildExpansionTile(String title, Widget content) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
        ],
      ),
      children: [content],
    );
  }

  Widget buildEditProfileContent() {
    return ListTile(
      title: Text('Edit your profile information here.'),
    );
  }

  Widget buildMyOrdersContent() {
    return ListTile(
      title: Text('Order 1: '),
      subtitle: Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}'),
    );
  }

  Widget buildPaymentMethodContent() {
    return ListTile(
      title: Text('Payments: '),
    );
  }

  Widget buildReviewsContent() {
    return ListTile(
      title: Text('Reviews: '),
    );
  }

  Widget buildSettingsContent() {
    return ListTile(
      title: Text('Settings: '),
    );
  }

  Widget buildAboutUsContent() {
    return ListTile(
      title: Text('Information about us.'),
    );
  }

  void signOut(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    showToast('Signed out successfully');
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
}
