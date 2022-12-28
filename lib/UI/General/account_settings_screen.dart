import "package:flutter/material.dart";
import 'package:login/Models/Speciality.dart';
import 'package:login/Models/technician.dart';
import 'package:login/UI/Auth/login_screen.dart';
import 'package:login/UI/General/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login/Utils/http_helper.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  SharedPreferences? prefs;
  late Technician technician;
  late Speciality speciality;
  late int id;
  HttpHelper? helper;

  @override
  void initState() {
    helper = HttpHelper();
    speciality = Speciality(null, "...");
    technician = Technician(null, "...", "...", "...", "...", "...", "...",
        "...", "...", null, "...", null, speciality);
    initialize();
    super.initState();
  }

  Future initialize() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs!.getInt("id")!;
    technician = (await helper?.getTechnicianById(id))!;
    setState(() {
      technician = technician;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Debe ir la foto de perfil, el nombre del usuario y el botón de editar perfil
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
                backgroundImage: NetworkImage("${technician.imageUrl}"),
                minRadius: 50.0,
                maxRadius: 50.0),
          ),

          const SizedBox(height: 20),
          Text(
            "${technician.name} ${technician.lastName}",
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),
          Text.rich(TextSpan(
              text: 'Username: ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: technician.username,
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 5),
          Text.rich(TextSpan(
              text: 'Email: ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: technician.email,
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 5),
          Text.rich(TextSpan(
              text: 'Telephone Number: ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: technician.telephoneNumber,
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 5),
          Text.rich(TextSpan(
              text: 'ID Card: ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: technician.dni,
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 5),
          Text.rich(TextSpan(
              text: 'Address: ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: technician.district,
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 10),
          Text.rich(TextSpan(
              text: 'Speciality: ',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: technician.speciality!.name,
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 5),
          Text.rich(TextSpan(
              text: 'Description: ',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: technician.professionalProfile,
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 5),
          Text.rich(TextSpan(
              text: 'Score: ',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: "${technician.valoration}",
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),

          const SizedBox(height: 20),
          MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(technician)));
              },
              color: const Color(0xFF0332FC),
              child: const Text("Edit Profile",
                  style: TextStyle(color: Colors.white))),

          const SizedBox(height: 5),
          MaterialButton(
              minWidth: double.infinity,
              onPressed: () async {
                prefs = await SharedPreferences.getInstance();
                prefs?.remove("id");
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              color: const Color(0xFF0332FC),
              child:
                  const Text("Logout", style: TextStyle(color: Colors.white))),
        ],
      ),
    )));
  }
}
