import 'package:calendar_app/pages/HomePage.dart';
import 'package:calendar_app/users/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late FirebaseAuth auth;
  bool isVisiblity = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: buildColumn(context),
      )),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        const SizedBox(
          height: 50,
        ),
        const Padding(
          padding: EdgeInsets.only(
            bottom: 40,
          ),
          child: Text(
            'Login',
            style: TextStyle(
                fontSize: 28, fontFamily: 'Bitter', color: Colors.black),
          ),
        ),
        buildEmailTextfield(),
        buildPassTextField(),
        Padding(
          padding: const EdgeInsets.only(right: 17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Şifremi Unuttum ',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            var userCredential = await auth.signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
            if (auth.currentUser!.emailVerified == true) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else {
              return;
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
              child: const Text('Giriş',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 3, top: 5),
              width: 150,
              height: 0.5,
              color: Colors.black,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Text('veya'),
            ),
            Container(
                margin: const EdgeInsets.only(left: 3, top: 5),
                width: 150,
                height: 0.5,
                color: Colors.black)
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                color: const Color(0xfff4ae06),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: const Icon(
                    Icons.mail_outlined,
                    color: Colors.white,
                  ),
                ),
                const Text('Gmail',
                    //  textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hesabınız Yok mu ?'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  'KAYIT OL',
                  style: TextStyle(
                    color: Color(0xfff4ae06),
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container buildEmailTextfield() {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(
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
    );
  }

  Container buildPassTextField() {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
      child: TextField(
        obscureText: isVisiblity,
        controller: passwordController,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isVisiblity = !isVisiblity;
                });
              },
              child: const Icon(
                Icons.visibility,
                color: Colors.black,
                size: 22,
              )),
          label: const Text(
            'Password',
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
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
