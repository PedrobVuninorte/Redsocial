import 'package:red_social_get/domain/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseSignUp extends StatefulWidget {
  const FirebaseSignUp({Key? key}) : super(key: key);

  @override
  _FirebaseSignUpState createState() => _FirebaseSignUpState();
}

class _FirebaseSignUpState extends State<FirebaseSignUp> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  _signup(theEmail, thePassword) async {
    try {
      await authenticationController.signUp(theEmail, thePassword);

      Get.snackbar(
        "Sign Up",
        'OK',
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      Get.snackbar(
        "Sign Up",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up Information",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controllerEmail,
                  decoration: const InputDecoration(labelText: "Email address"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter email";
                    } else if (!value.contains('@')) {
                      return "Enter valid email address";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controllerPassword,
                  decoration: const InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    } else if (value.length < 6) {
                      return "Password should have at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    form!.save();
                    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      _signup(controllerEmail.text, controllerPassword.text);
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
