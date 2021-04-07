import 'package:pizza_finder/screens/signin/signin.dart';
import 'package:pizza_finder/screens/home/home.dart';
import 'package:pizza_finder/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppRouter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Pizza Finder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.black26,
        canvasColor: Colors.white,

        primaryTextTheme: GoogleFonts.poppinsTextTheme(),

        textTheme: GoogleFonts.poppinsTextTheme(),

      ),
      routes: {
        '/':            (context) => SplashView(),
        '/login':       (context) => SignInScreen(),
        '/home':        (context) => HomeView()
      },
      initialRoute: '/'
    );
  }

}