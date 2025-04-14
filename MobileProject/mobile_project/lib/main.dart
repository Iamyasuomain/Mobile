// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/uploadpic.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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

PreferredSizeWidget AppBarCustom(String title) {
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
                onPressed: () {},
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
return Scaffold(
  bottomNavigationBar: ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
    child: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: const Color.fromARGB(255, 30, 55, 43),
        backgroundColor: const Color(0xFF2F5241),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(  //this just change icon color base on widget state 
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFFFFFFE2)); 
            }
            return const IconThemeData(color: Color(0xFFD6CFB9)); 
          },
        ),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: Color(0xFFFFFFE2), fontWeight: FontWeight.bold); 
            }
            return const TextStyle(color: Color(0xFFD6CFB9)); 
          },
        ),
      ),
      child: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_camera_outlined),
            label: "Photo",
          ),
          NavigationDestination(
            icon: Icon(Icons.stacked_bar_chart),
            label: "Stat",
          ),
          NavigationDestination(
            icon: Icon(Icons.phonelink_setup_outlined),
            label: "Device",
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box_outlined),
            label: "Status",
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    ),
  ),
  body: IndexedStack(
    index: _selectedIndex,
    children: const [
      Login(),
      Register(),
      Uploadpic(),
      Placeholder(),
      Placeholder(),
    ],
  ),
);
  }
}
