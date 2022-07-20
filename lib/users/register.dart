import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late FirebaseAuth auth;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/Gray_Logo_Transparent.png'))),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 30,
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      'Ad Soyad',
                      style: TextStyle(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        //  style: BorderStyle.none,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        //  style: BorderStyle.none,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(
                  top: 10,
                  right: 30,
                  left: 30,
                ),
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      'Email',
                      style: TextStyle(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        //  style: BorderStyle.none,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        //  style: BorderStyle.none,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(
                  top: 10,
                  right: 30,
                  left: 30,
                ),
                child: TextField(
                  controller: passwordController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      'Şifre',
                      style: TextStyle(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        //  style: BorderStyle.none,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        //  style: BorderStyle.none,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  createUser();
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                    left: 30,
                    right: 30,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xfff4ae06),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text('Kayıt Ol',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createUser() async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var _myUser = userCredential.user;
      if (!_myUser!.emailVerified) {
        await _myUser.sendEmailVerification();
      } else {
        debugPrint('maili onaylanmış');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
