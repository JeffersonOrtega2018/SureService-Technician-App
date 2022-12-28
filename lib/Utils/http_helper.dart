import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:login/Models/Speciality.dart';
import 'package:login/Models/service_request.dart';
import 'package:login/Models/technician.dart';
import 'package:login/Models/technician_login.dart';

import '../Models/reservation_request.dart';

class HttpHelper {
  final String urlBase = 'https://sure-service.herokuapp.com/api/v1';
  final String urlServiceRequest = '/services';
  final String urlPassword = '/users/password';
  final String urlSpeciality = '/speciality';
  final String urlTechnician = '/technician';
  final String urlLogin = "/users/auth/sign-in";
  final String urlReservations = "/reservations";

  Future<int?> login(TechnicianLogin user) async {
    http.Response result = await http.post(
      Uri.parse(urlBase + urlLogin),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return jsonResponse['id'] as int;
    }

    return null;
  }

  Future<List?> getReservationsByTechnician(int technicianId) async {
    final String url = '$urlBase$urlReservations$urlTechnician/$technicianId';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final serviceRequestMap = jsonResponse;
      List serviceRequest =
          serviceRequestMap.map((i) => ReservationRequest.fromJson(i)).toList();
      return serviceRequest;
    } else {
      return null;
    }
  }

  Future<List?> getServicesRequestByTechnician(int technicianId) async {
    final String url = '$urlBase$urlServiceRequest$urlTechnician/$technicianId';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final serviceRequestMap = jsonResponse;
      List serviceRequest =
          serviceRequestMap.map((i) => ServiceRequest.fromJson(i)).toList();
      return serviceRequest;
    } else {
      return null;
    }
  }

  Future<int> editServiceRequest(ServiceRequest serviceRequest) async {
    final String url = '$urlBase$urlServiceRequest/${serviceRequest.id}';
    final editServiceRequestUrl = Uri.parse(url);
    http.Response result = await http.put(editServiceRequestUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "total_price": "${serviceRequest.totalPrice}",
          "reservation_price": "${serviceRequest.reservationPrice}",
          "confirmation": "${serviceRequest.confirmation}"
        }));
    return result.statusCode;
  }

  Future<Technician?> getTechnicianById(int id) async {
    final String url = '$urlBase$urlTechnician/$id';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      Technician technician = Technician.fromJson(jsonResponse);
      return technician;
    } else {
      return null;
    }
  }

  Future<List?> getSpecialities() async {
    final String url = '$urlBase$urlSpeciality';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final specialitiesMap = jsonResponse;
      List specialities =
          specialitiesMap.map((i) => Speciality.fromJson(i)).toList();
      return specialities;
    } else {
      return null;
    }
  }

  Future<int> editTechnician(Technician technician) async {
    final String url = '$urlBase$urlTechnician/${technician.id}';
    final editTechnicianUrl = Uri.parse(url);
    http.Response result = await http.put(editTechnicianUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": "${technician.username}", //
          "email": "${technician.email}", //
          "name": "${technician.name}", //
          "last_name": "${technician.lastName}", //
          "telephone_number": "${technician.telephoneNumber}", //
          "dni": "${technician.dni}", //
          "professional_profile": "${technician.professionalProfile}", //
          "district": "${technician.district}",
          "speciality": "${technician.speciality!.id}",
          "valoration": "${technician.valoration}", //
          "disponibility": "${technician.disponibility}", //
        }));

    return result.statusCode;
  }

  Future<int> editPassword(
      int id, String password, String confirmPassword) async {
    final String url = '$urlBase$urlPassword/$id';
    final editPasswordUrl = Uri.parse(url);
    http.Response result = await http.put(editPasswordUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "newPassword": password,
          "confirmPassword": confirmPassword
        }));

    return result.statusCode;
  }
}
