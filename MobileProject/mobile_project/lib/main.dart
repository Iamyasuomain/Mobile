// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_project/pages/archievement.dart';
import 'package:mobile_project/pages/display.dart';
import 'package:mobile_project/pages/modelresponse.dart';
import 'package:mobile_project/pages/setting.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/uploadpic.dart';
import 'pages/stat.dart';
import 'pages/home.dart';
import '../services/Notiservices.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService notificationService = NotificationService();
  await notificationService.requestNotificationPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page(),
    );
  }
}

PreferredSizeWidget AppBarCustom(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100.0),
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2F5241), // from Figma
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            Center(
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold))),
            Positioned(
              top: -10,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user == null) {
          return const Login();
        }
        var pages = [
          HomePage(),
          Uploadpic(), // Stat
          Archivement(), // Device
          Stat(),
          SettingsScreen(),
        ];
        pages = pages.where((page) => page != null).toList();
        const navItems = [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.photo_camera_outlined), label: "Photo"),
          NavigationDestination(
              icon: Icon(Icons.stacked_bar_chart), label: "Stat"),
          NavigationDestination(
              icon: Icon(Icons.phonelink_setup_outlined), label: "Monitering"),
          NavigationDestination(
              icon: Icon(Icons.check_box_outlined), label: "Status"),
        ];

        return Scaffold(
          extendBody: true,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: const Color.fromARGB(255, 30, 55, 43),
                backgroundColor: const Color(0xFF2F5241),
                iconTheme: WidgetStateProperty.all(
                    const IconThemeData(color: Colors.white)),
                labelTextStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.white)),
              ),
              child: NavigationBar(
                destinations: navItems,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),
        );
      },
    );
  }
}

class Nav extends StatelessWidget {
  final String text;
  const Nav({
    super.key,
    required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0xFF2D5543),
      ),

      child: Container(
        padding: const EdgeInsets.only(
          top: 50,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF2D5543),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}