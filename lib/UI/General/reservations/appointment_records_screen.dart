import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/reservation_request.dart';
import '../../../Utils/http_helper.dart';

class AppointmentRecordScreen extends StatefulWidget {
  const AppointmentRecordScreen({super.key});

  @override
  State<AppointmentRecordScreen> createState() =>
      _AppointmentRecordScreenState();
}

class _AppointmentRecordScreenState extends State<AppointmentRecordScreen> {
  List? serviceReservation;
  int? serviceReservationCount;
  int? idTechnician;
  SharedPreferences? prefs;
  HttpHelper? helper;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    prefs = await SharedPreferences.getInstance();
    serviceReservation = List.empty();
    idTechnician = prefs!.getInt('id') ?? 14;
    serviceReservation =
        await helper?.getReservationsByTechnician(idTechnician!);
    setState(() {
      serviceReservationCount = serviceReservation?.length;
      serviceReservation = serviceReservation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: ListView.builder(
        itemCount:
            (serviceReservationCount == null) ? 0 : serviceReservationCount,
        itemBuilder: ((context, index) {
          return ReservationItem(serviceReservation![index]);
        }),
      ),
    ));
  }
}

class ReservationItem extends StatefulWidget {
  final ReservationRequest serviceReservationItem;
  const ReservationItem(this.serviceReservationItem, {super.key});

  @override
  State<ReservationItem> createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        //El card debe tener una foto en la parte superior, el nombre del usuario, la fecha de solicitud y el botón mas información
        child: Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "${widget.serviceReservationItem.serviceRequest?.client!.imageUrl}")),
          //El title debe ser el nombre del usuario
          title: Text(
              "${widget.serviceReservationItem.serviceRequest!.client!.name} ${widget.serviceReservationItem.serviceRequest!.client!.lastName}"),
          subtitle: const Text("9/10/2021"),
        ),
        Padding(
          //Solo agregar padding arriba.
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.serviceReservationItem.serviceRequest!.detail!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          //Solo agregar padding arriba.
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            children: <Widget>[
              const Text(
                "Phone number: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.serviceReservationItem.serviceRequest!.client!
                  .telephoneNumber!),
            ],
          ),
        ),
        Padding(
          padding: //El padding debe ir abajo del todo.
              const EdgeInsets.only(top: 5, bottom: 10, left: 15, right: 15),
          child: Row(
            children: <Widget>[
              // La parte de "Address" debe estar en negrita.
              const Text(
                "Total Price: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.serviceReservationItem.serviceRequest!.totalPrice!
                  .toString()),
            ],
          ),
        ),
      ],
    ));
  }
}
