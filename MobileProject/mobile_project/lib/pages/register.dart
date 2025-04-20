// note: need to fix bottom overflow when user trying to type in the TextFormField
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(context, "Register"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Email',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 20),
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFFFEEC2),
                                    hintText: 'email@email.com',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(23),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Username',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 20),
                                child: TextFormField(
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your username";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFFFEEC2),
                                    hintText: 'username',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(23),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Password',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 20),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters long';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFFFEEC2),
                                    hintText: 'password',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(23),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Confirm Password',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 20),
                                child: TextFormField(
                                  controller: confirmController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    } else if (value !=
                                        passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFFFEEC2),
                                    hintText: '***********',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(23),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      // ignore: unused_local_variable
                      if (_formkey.currentState!.validate()) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        }).catchError((error) {
                          print(error);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFFFEEC2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12), // Adjust button size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(23), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: TextButton(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
