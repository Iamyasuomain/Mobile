// note: need to fix bottom overflow when user trying to type in the textfield
import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom("Register"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 520,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBF6E9),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(23), top: Radius.circular(23)),
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
                      Container(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFEEC2),
                            hintText: 'email@email.com',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintStyle: const TextStyle(color: Colors.grey),
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
                        padding: const EdgeInsets.only(left: 20,bottom: 20),
                        child: TextField(
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFEEC2),
                            hintText: 'username',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintStyle: const TextStyle(color: Colors.grey),
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
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFEEC2),
                            hintText: 'password',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintStyle: const TextStyle(color: Colors.grey),
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
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: TextField(
                          controller: confirmController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFEEC2),
                            hintText: '***********',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      print("test");
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
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                    
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
