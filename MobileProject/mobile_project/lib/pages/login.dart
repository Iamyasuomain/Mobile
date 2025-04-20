import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/pages/register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Future<void> saveFCMToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        await Future.delayed(const Duration(seconds: 5));
        fcmToken = await FirebaseMessaging.instance.getToken();

        if (fcmToken != null) {
          FirebaseFirestore.instance.collection('fcmToken').doc(user.uid).set({
            'fcmToken': fcmToken,
          }, SetOptions(merge: true));
          print("FCM Token saved: $fcmToken");
        } else {
          print("FCM Token is still null after retry.");
        }
      } else {
        FirebaseFirestore.instance.collection('fcmToken').doc(user.uid).set({
          'fcmToken': fcmToken,
        }, SetOptions(merge: true));
        print("FCM Token saved: $fcmToken");
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(context, "Login"),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 100),
                        width: 350,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFBF6E9),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(23),
                              top: Radius.circular(23)),
                        ),
                        child: Column(
                          children: [
                            Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Email',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      child: TextFormField(
                                        controller: emailController,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          } else if (!RegExp(
                                                  r'^[^@]+@[^@]+\.[^@]+$')
                                              .hasMatch(value)) {
                                            return 'Please enter a valid email address';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFFFEEC2),
                                          hintText: 'email@email.com',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Password',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        controller: passwordController,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          } else {
                                            return null;
                                          }
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFFFEEC2),
                                          hintText: 'password',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: ()  {
                        if (_formkey.currentState!.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim())
                              .then((value) {
                                saveFCMToken();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const MyApp();
                            }));
                          }).catchError((error) {
                            print(error);
                            if (error.toString().contains(
                                "[firebase_auth/invalid-credential]")) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Invalid email or password"),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Something went wrong"),
                                duration: Duration(seconds: 2),
                              ));
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFFFEEC2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12), 
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(23), 
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont have an account?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
