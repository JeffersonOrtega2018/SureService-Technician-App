import 'package:flutter/material.dart';
import 'package:login/UI/General/home_page_screen.dart';
import 'package:login/Utils/http_helper.dart';

class ChangePassword extends StatefulWidget {
  final int id;
  const ChangePassword(this.id, {super.key});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  late String password;
  late String confirmPassword;
  late int statusCode;
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;
  HttpHelper? helper;

  @override
  void initState() {
    helper = HttpHelper();
    statusCode = 0;
    password = "";
    confirmPassword = "";
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    super.initState();
  }

  //Future change password
  Future updatePassword() async {
    statusCode = (await helper?.editPassword(widget.id, password, confirmPassword))!;
    setState(() {
      statusCode = statusCode;
      if (statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password updated succesfuly")));

        MaterialPageRoute route =
            MaterialPageRoute(builder: (_) => const HomeScreen());
        Navigator.push(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Type your new password",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: (String value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value!.length < 3) {
                            return "You must enter a password with 3 characters as minimun";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: !_confirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                          hintText: "Repeat your new password",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: (String value) {
                          confirmPassword = value;
                        },
                        validator: (value) {
                          if (value!.length < 3) {
                            return "You must enter a password with 3 characters as minimun";
                          } else if (value != password) {
                            return "Your confirmation password must to be same the password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updatePassword();
                            }
                          },
                          color: const Color(0xFF0332FC),
                          child: const Text("Update password",
                              style: TextStyle(color: Colors.white))),
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: const Color(0xFF0332FC),
                          child: const Text("Back",
                              style: TextStyle(color: Colors.white))),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )))),
    );
  }
}
