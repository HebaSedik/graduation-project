import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_app/preseitation-layer/screens/bottomnavScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset(
            "assets/iHaven Logo.png",
            height: 230,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Developed By',
              style: GoogleFonts.lora(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.normal,
              )),
          Text('iHaven Team',
              style: GoogleFonts.lora(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              )),
        ],
      ),
      backgroundColor: Colors.black,
      splashIconSize: MediaQuery.of(context).size.width,
      duration: 2000,
      splashTransition: SplashTransition.sizeTransition,
      animationDuration: const Duration(seconds: 3),
      nextScreen: BottomNaveScreen(),
    );
  }
}

customTextStyel(
    {required double fontSize,
    required FontWeight fontWeight,
    required String fontFamily}) {
  return TextStyle(
    color: Colors.white,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}
