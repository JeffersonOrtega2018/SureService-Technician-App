import 'package:login/Models/service_request.dart';

import "package:flutter/material.dart";
import 'package:login/UI/General/home_page_screen.dart';
import 'package:login/UI/General/pending_requests/accept_pending_request.dart';

import '../../../Utils/http_helper.dart';

class PendingRequestDetail extends StatefulWidget {
  final ServiceRequest serviceRequest;
  const PendingRequestDetail(this.serviceRequest, {super.key});

  @override
  State<PendingRequestDetail> createState() => _PendingRequestDetail();
}

class _PendingRequestDetail extends State<PendingRequestDetail> {
  HttpHelper? helper;
  late int statusCode;

  @override
  void initState() {
    helper = HttpHelper();
    statusCode = 0;
    super.initState();
  }

  Future sendData() async {
    statusCode = (await helper?.editServiceRequest(widget.serviceRequest))!;
    setState(() {
      statusCode = statusCode;
      if (statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Servicio rechazado con éxito")));
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
            Text(
              "${widget.serviceRequest.client!.name} ${widget.serviceRequest.client!.lastName}",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 80),
            MaterialButton(
              minWidth: double.maxFinite,
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) =>
                        AcceptPendingRequest(widget.serviceRequest));
                Navigator.push(context, route);
              },
              color: const Color(0xFF0332FC),
              child:
                  const Text("ACCEPT", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              minWidth: double.maxFinite,
              onPressed: () {
                setState(() {
                  widget.serviceRequest.confirmation = 2;
                });
                sendData();
              },
              color: const Color(0xFFFC0303),
              child:
                  const Text("REFUSE", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ));
  }
}
