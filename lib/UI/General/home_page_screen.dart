import "package:flutter/material.dart";
import 'package:login/UI/General/account_settings_screen.dart';
import 'package:login/UI/General/reservations/appointment_records_screen.dart';
import 'package:login/UI/General/pending_requests/pending_requests_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pages = [
    const PendingRequestScreen(),
    const AppointmentRecordScreen(),
    const AccountSettingsScreen(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0332FC),
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Pending Requests",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "Appointment Records",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      );
    });
  }
}
