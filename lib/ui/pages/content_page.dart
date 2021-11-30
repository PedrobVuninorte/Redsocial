import 'package:loggy/loggy.dart';
import 'package:red_social_get/domain/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/chat_page.dart';
import '../widgets/firestore_page.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int _selectIndex = 0;
  AuthenticationController authenticationController = Get.find();
  static final List<Widget> _widgets = <Widget>[const FireStorePage(), const ChatPage()];

  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  _logout() async {
    try {
      await authenticationController.logOut();
    } catch (e) {
      logError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${authenticationController.userEmail()}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Firestore"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Chat"),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
