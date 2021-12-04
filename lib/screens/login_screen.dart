import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/networking.dart';
import 'chooseCity.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundBlue,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 240,
                      height: 240,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Book My Book',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 48, color: kDarkBlue),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 48.0),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kLightBlue, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(
                          iconSize: 42,
                          icon: Image(
                              image:
                                  AssetImage('assets/images/googleLogo.png')),
                          onPressed: () async {
                            await signInWithGoogle();
                            Navigator.pushNamed(context, CityChooser.id);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      'Sign In With Google',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12,
                            color: kDarkBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            //TODO : Add email and phone login option
          ),
        ),
      ),
    );
  }
}
