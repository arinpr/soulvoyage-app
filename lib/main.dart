import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulvoyage/screen/onBoard/Onboard.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: Builder(
        builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler:const TextScaler.linear(1.0)), // Set fixed text scale
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SoulVoyage',
              theme: ThemeData(
                // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                textTheme: GoogleFonts.redHatDisplayTextTheme(),
                useMaterial3: false,
              ),
              home: FlutterSplashScreen.scale(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.lightBlue,
                    Colors.white,
                  ],
                ),
                childWidget: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        child: Image.asset("assets/logo.png"),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "SoulVoyage",
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                duration: const Duration(milliseconds: 3500),
                animationDuration: const Duration(milliseconds: 2000),
                onAnimationEnd: () => debugPrint("On Scale End"),
                nextScreen: const OnboardingScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
