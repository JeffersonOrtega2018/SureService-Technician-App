import "package:flutter/material.dart";
import 'package:email_validator/email_validator.dart';
import 'package:login/Models/technician.dart';
import 'package:login/UI/General/change_password.dart';
import 'package:login/UI/General/home_page_screen.dart';

import '../../Utils/http_helper.dart';

class EditProfileScreen extends StatefulWidget {
  final Technician technician;
  const EditProfileScreen(this.technician, {super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyPicture = GlobalKey<FormState>();
  final _validatorKey = GlobalKey<ScaffoldMessengerState>();

  final List<String> districts = [
    "Ancón",
    "Ate",
    "Barranco",
    "Breña",
    "Carabayllo",
    "Cercado de Lima",
    "Chaclacayo",
    "Chorrillos",
    "Cieneguilla",
    "Comas",
    "El agustino",
    "Independencia",
    "Jesús maría",
    "La molina",
    "La victoria",
    "Lince",
    "Los olivos",
    "Lurigancho",
    "Lurín",
    "Magdalena del mar",
    "Miraflores",
    "Pachacamac",
    "Pucusana",
    "Pueblo libre",
    "Puente piedra",
    "Punta hermosa",
    "Punta negra",
    "Rímac",
    "San bartolo",
    "San borja",
    "San isidro",
    "San juan de lurigancho",
    "San juan de miraflores",
    "San luis",
    "San martin de porres",
    "San miguel",
    "Santa anita",
    "Santa maría del mar",
    "Santa rosa",
    "Santiago de surco",
    "Surco",
    "Surquillo",
    "Villa el salvador",
    "Villa maría del triunfo",
    "Otro"
  ];

  String dropdownvalue = 'Otro';
  String? selectedValue;
  List? specialities;
  late int statusCode;
  HttpHelper? helper;

  @override
  void initState() {
    helper = HttpHelper();
    statusCode = 0;
    initialize();
    contentDistrict();
    super.initState();
  }

  Future initialize() async {
    specialities = List.empty();
    specialities = (await helper?.getSpecialities())!;
    setState(() {
      specialities = specialities;
    });
  }

  Future sendData() async {
    statusCode = (await helper?.editTechnician(widget.technician))!;
    setState(() {
      statusCode = statusCode;
      if (statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Edit profile succesful")));

        MaterialPageRoute route =
            MaterialPageRoute(builder: (_) => const HomeScreen());
        Navigator.push(context, route);
      }
    });
  }

  void contentDistrict() {
    if (districts.contains(widget.technician.district)) {
      dropdownvalue = widget.technician.district!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: _validatorKey,
        //Desativar o banner de debug
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(children: [
                const Text("Edit profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                // Debe ir la foto de perfil y un boton para cambiarla
                Form(
                  key: _formKeyPicture,
                  child: Column(children: [
                    CircleAvatar(
                        backgroundImage:
                            NetworkImage("${widget.technician.imageUrl}"),
                        minRadius: 40.0,
                        maxRadius: 40.0),
                    const SizedBox(height: 10),
                    /*
                    IconButton(
                      icon: Image.network("${widget.technician.imageUrl}"),
                      style: ,
                      iconSize: 60,
                      onPressed: () {},
                    ),*/
                    MaterialButton(
                      minWidth: 200,
                      onPressed: () {},
                      color: const Color(0xFF0332FC),
                      child: const Text("Change profile picture",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ]),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: widget.technician.name,
                            decoration: InputDecoration(
                              labelText: "Name",
                              hintText: "${widget.technician.name}",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String value) {
                              widget.technician.name = value;
                            },
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Please enter name"
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: widget.technician.lastName,
                            decoration: InputDecoration(
                              labelText: "Lastname",
                              hintText: "${widget.technician.lastName}",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String value) {
                              widget.technician.lastName = value;
                            },
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Please enter lastname"
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: widget.technician.username,
                            decoration: InputDecoration(
                              labelText: "Username",
                              hintText: "${widget.technician.username}",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String value) {
                              widget.technician.username = value;
                            },
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Please enter username"
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: widget.technician.telephoneNumber,
                            decoration: InputDecoration(
                              labelText: "Telephone Number",
                              hintText: "${widget.technician.telephoneNumber}",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String value) {
                              widget.technician.telephoneNumber = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You must enter a mobile number";
                              } else if (value.length < 9) {
                                return "Please enter a correct mobile number";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: widget.technician.dni,
                            decoration: InputDecoration(
                              labelText: "ID Card",
                              hintText: "${widget.technician.dni}",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String value) {
                              widget.technician.dni = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You must enter a ID Card";
                              } else if (value.length < 8) {
                                return "Please enter a correct ID Card";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            initialValue: widget.technician.email,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "${widget.technician.email}",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String value) {
                              widget.technician.email = value;
                            },
                            validator: (value) {
                              final bool isValid =
                                  EmailValidator.validate(value!);
                              if (isValid) {
                                return null;
                              } else {
                                return "You must enter a correct email";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: widget.technician.professionalProfile,
                            decoration: InputDecoration(
                              labelText: "Description",
                              hintText:
                                  "${widget.technician.professionalProfile}",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String value) {
                              widget.technician.professionalProfile = value;
                            },
                            minLines: 2,
                            maxLines: 5,
                            validator: (value) {
                              if (value!.length < 10) {
                                return "You must enter a description with 10 characters as minimun";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          DropdownButtonFormField(
                            validator: (value) =>
                                value == null ? 'Field required' : null,
                            // Initial Value
                            isExpanded: true,
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: districts.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                widget.technician.district = newValue;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //Button update profile
                          MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  sendData();
                                }
                              },
                              color: const Color(0xFF0332FC),
                              child: const Text("Update information",
                                  style: TextStyle(color: Colors.white))),
                          const SizedBox(
                            height: 15,
                          ),

                          MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangePassword(
                                            widget.technician.id!.toInt())));
                              },
                              color: const Color(0xFF0332FC),
                              child: const Text("Change password",
                                  style: TextStyle(color: Colors.white))),
                        ]),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
