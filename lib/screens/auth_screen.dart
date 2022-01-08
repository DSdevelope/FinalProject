import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  static const borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(36)),
      borderSide: BorderSide(
          color: Colors.transparent, width: 2)
  );
  static const linkTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bc_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100,),
                const SizedBox(
                  width: 250,
                  height: 250,
                  child: Image(image: AssetImage('assets/logo.png')),
                ),
                const SizedBox(height: 20,),
                const Text(Strings.enterPhoneNumber,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 26,),
                const TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFeceff1),
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    labelText: Strings.phone,
                  ),
                ),
                const SizedBox(height: 30,),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFeceff1),
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    labelText: Strings.password,
                  ),
                ),
                const SizedBox(height: 44,),
                SizedBox(
                  width: 196,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                        Strings.enter,
                        style: TextStyle(fontSize: 22)
                      ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF0079D0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 52,),
                InkWell(
                  child: const Text(Strings.registration, style: linkTextStyle,),
                  onTap: () {}
                  ),
                const SizedBox(height: 40,),
                InkWell(
                  child: const Text(Strings.forgotPassword, style: linkTextStyle,),
                  onTap: () {}
                  )
              ],
            ),
          ),
        ),
    );
  }
}
