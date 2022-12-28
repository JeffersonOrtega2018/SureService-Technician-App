import "package:flutter/material.dart";
import 'package:login/Models/technician_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/technician.dart';
import '../../Utils/http_helper.dart';
import '../General/home_page_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _validatorKey = GlobalKey<ScaffoldMessengerState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  HttpHelper? httpHelper;
  Technician? user;
  int? id;

  @override
  void initState() {
    httpHelper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _validatorKey,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Login",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: userNameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "Username",
                              hintText: "Your username",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Please enter username"
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                                labelText: "Password",
                                hintText: "Your password",
                                border: OutlineInputBorder(),
                                suffixIcon: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(Icons.visibility),
                                )),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Please enter username"
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () {
                                final user = TechnicianLogin(userNameController.text,
                                    passwordController.text);
                                login(user);
                              },
                              /*if (_formKey.currentState!.validate()) {
                                  _validatorKey.currentState!.showSnackBar(
                                    const SnackBar(
                                      content: Text("Login successful"),
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                      (route) => false);
                                      */
                              color: const Color(0xFF0332FC),
                              child: const Text("LOGIN",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Do not have an account?"),
                            TextButton(
                              onPressed: () {
                                // Press sign in to sign up
                              },
                              child: const Text("Sign Up"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login(TechnicianLogin user) async {
    id = await httpHelper?.login(user);
    final prefs = await SharedPreferences.getInstance();
    if (id != null) {
      setState(() {
        id = id;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      });
      await prefs.setInt('id', id!);
    }
    //Si el id es null, entonces no se pudo loguear
    else {
      _validatorKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Username or password incorrect"),
        ),
      );
    }
  }
}
