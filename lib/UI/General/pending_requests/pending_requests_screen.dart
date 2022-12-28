import "package:flutter/material.dart";
import 'package:login/Models/service_request.dart';
import 'package:login/UI/General/pending_requests/pending_request_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/http_helper.dart';

class PendingRequestScreen extends StatefulWidget {
  const PendingRequestScreen({super.key});

  @override
  State<PendingRequestScreen> createState() => _PendingRequestScreenState();
}

class _PendingRequestScreenState extends State<PendingRequestScreen> {
  int? serviceRequestCount;
  List? serviceRequest;
  SharedPreferences? prefs;
  HttpHelper? helper;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    serviceRequest = List.empty();
    prefs = await SharedPreferences.getInstance();
    serviceRequest = await helper?.getServicesRequestByTechnician(prefs!.getInt("id")!);
    setState(() {
      serviceRequestCount = serviceRequest?.length;
      serviceRequest = serviceRequest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: ListView.builder(
        itemCount: (serviceRequestCount == null) ? 0 : serviceRequestCount,
        itemBuilder: ((context, index) {
          return ServiceRequestItem(serviceRequest![index]);
        }),
      ),
    ));
  }
}

class ServiceRequestItem extends StatefulWidget {
  final ServiceRequest serviceRequest;
  const ServiceRequestItem(this.serviceRequest, {super.key});

  @override
  State<ServiceRequestItem> createState() => _ServiceRequestItemState();
}

class _ServiceRequestItemState extends State<ServiceRequestItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //El card debe tener una foto en la parte superior, el nombre del usuario, la fecha de solicitud y el botón mas información
      elevation: 3.0,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundImage:
                    NetworkImage("${widget.serviceRequest.client!.imageUrl}")),
            title: Text(
                "${widget.serviceRequest.client!.name} ${widget.serviceRequest.client!.lastName}"),
            subtitle: const Text('20/12/2022'),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            alignment: Alignment.centerLeft,
            child: Text(widget.serviceRequest.detail!),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  if (widget.serviceRequest.confirmation == 0)
                    TextButton(
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (_) =>
                                  PendingRequestDetail(widget.serviceRequest));
                          Navigator.push(context, route);
                        },
                        child: const Text("MORE INFO")),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        if (widget.serviceRequest.confirmation != 0)
                          const SizedBox(height: 10),
                        if (widget.serviceRequest.confirmation == 1)
                          const Text(
                            "ACCEPT",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF0332FC),
                                fontWeight: FontWeight.w700),
                          ),
                        if (widget.serviceRequest.confirmation == 2)
                          const Text(
                            "REJECTED",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFC0303),
                                fontWeight: FontWeight.w700),
                          ),
                        if (widget.serviceRequest.confirmation == 3)
                          const Text(
                            "PAID OUT",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w700),
                          ),
                        if (widget.serviceRequest.confirmation != 0)
                          const SizedBox(height: 15),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
