import 'package:login/Models/service_request.dart';

class ReservationRequest {
  int? id;
  String? dateof;
  int? status;
  ServiceRequest? serviceRequest;

  ReservationRequest(this.id, this.dateof, this.status, this.serviceRequest);

  ReservationRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateof = json['date_of'].toString();
    status = json['status'];
    serviceRequest = ServiceRequest.fromJson(json['serviceRequest']);
  }
}