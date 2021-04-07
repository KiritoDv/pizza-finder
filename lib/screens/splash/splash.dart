import 'package:pizza_finder/provider/signin_provider.dart';
import 'package:pizza_finder/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashView> {

  @override
  void initState() {

    SignInProvider provider = Provider.of(context, listen: false);

    provider.authenticate().then((logged) async {
      if(logged) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          height: 150,
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/icons/main-icon.png"),
        ),
      ),
    );
  }

}