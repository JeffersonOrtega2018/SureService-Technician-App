import 'package:flutter/material.dart';
import 'package:login/UI/General/home_page_screen.dart';
import 'package:login/Utils/http_helper.dart';

import '../../../Models/service_request.dart';

class AcceptPendingRequest extends StatefulWidget {
  final ServiceRequest serviceRequest;
  const AcceptPendingRequest(this.serviceRequest, {super.key});

  @override
  State<AcceptPendingRequest> createState() => _AcceptPendingRequest();
}

class _AcceptPendingRequest extends State<AcceptPendingRequest> {
  final _formKey = GlobalKey<FormState>();
  late String price;
  late int statusCode;
  HttpHelper? helper;

  @override
  void initState() {
    helper = HttpHelper();
    statusCode = 0;
    price = "";
    super.initState();
  }

  Future sendData() async {
    statusCode = (await helper?.editServiceRequest(widget.serviceRequest))!;
    setState(() {
      statusCode = statusCode;
      if (statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Servicio aceptado con éxito")));
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
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Choose price: ",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "${widget.serviceRequest.client!.name} ${widget.serviceRequest.client!.lastName}",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text.rich(TextSpan(
                text: 'ID: ',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: "${widget.serviceRequest.id}",
                      style: const TextStyle(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(height: 5),
            const Text.rich(TextSpan(
                text: 'Date: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: "20/12/2022",
                      style: TextStyle(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(height: 5),
            const Text.rich(TextSpan(
                text: 'Location: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: "Av. Los Girasoles 123, Surco, Lima",
                      style: TextStyle(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(height: 5),
            Text.rich(TextSpan(
                text: 'Phone Number: ',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.serviceRequest.client!.telephoneNumber,
                      style: const TextStyle(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(height: 5),
            Text.rich(TextSpan(
                text: 'Message: ',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: "${widget.serviceRequest.detail}",
                      style: const TextStyle(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Price",
                        hintText: "Choose price to service",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        price = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please choose a price";
                        }
                        if (double.parse(value) <= 0.0) {
                          return "Please choose a price greater than zero";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    MaterialButton(
                      minWidth: double.maxFinite,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            widget.serviceRequest.confirmation = 1;
                            widget.serviceRequest.reservationPrice =
                                int.parse(price);
                          });
                          sendData();
                        }
                      },
                      color: const Color(0xFF0332FC),
                      child: const Text("COMPLETE",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
