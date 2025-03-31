import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom("Login"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 275,
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
                        'Username',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
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
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
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
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (){
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
                    "Login",
                    style: TextStyle(fontSize: 22,color: Colors.black),
                  )),
                  SizedBox(height: 40,),
                  Text("Dont have an account?",style: TextStyle(fontSize: 18),)
            ],
          ),
        ));
  }
}
