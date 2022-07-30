import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  late FirebaseAuth auth;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
          child: Form(
            key: formKey,
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
                          image:
                              AssetImage('images/Gray_Logo_Transparent.png'))),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
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
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Şifre Giriniz';
                      }
                      return null;
                    },
                    controller: emailController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: const Text(
                        'Email',
                        style: TextStyle(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
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
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Şifre Giriniz';
                      } else if (value.length < 6) {
                        return 'Şifre 6 karakterden büyük olmalı ';
                      }
                      return null;
                    },
                    controller: passwordController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: const Text(
                        'Şifre',
                        style: TextStyle(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          //  style: BorderStyle.none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            //  style: BorderStyle.none,
                            color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    var validation = formKey.currentState!.validate();
                    if (validation) {
                      Navigator.pop(context);
                      createUser();
                      debugPrint(
                          'email : ${emailController.text}/ password : ${passwordController.text}');
                    } else if (!validation) {
                      showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text('Hata'),
                              content: const Text(
                                  'Boş Geçilen Kutucukları Doldurunuz'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'))
                              ],
                            )),
                      );
                    }
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
      ),
    );
  }

  Future<User?> createUser() async {
    var userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var myUser = userCredential.user;
      if (!myUser!.emailVerified) {
        await myUser.sendEmailVerification();
      } else {
        debugPrint('maili onaylanmış');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
     firestore.collection('users').doc(auth.currentUser!.uid);
    return userCredential.user;
  }
}
