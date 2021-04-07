import 'package:pizza_finder/provider/signin_provider.dart';
import 'package:pizza_finder/utils/FutureUtils.dart';
import 'package:pizza_finder/widgets/button.dart';
import 'package:pizza_finder/widgets/button_secondary.dart';
import 'package:pizza_finder/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    SignInProvider provider = Provider.of(context);


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image(
                  height: 150,
                  fit: BoxFit.fitHeight,
                  image: AssetImage("assets/icons/main-icon.png"),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextInputComponent(
                        placeholder: "Correo",
                        controller: provider.emailController,
                        type: TextInputType.emailAddress,
                        validator: (result) {

                        },
                      ),
                      SizedBox(height: 20,),
                      TextInputComponent(
                        controller: provider.passwordController,
                        placeholder: "Contraseña",
                        isPassword: true,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ButtonComponent(
                onTap: () async {
                  FutureUtils.showLoading(context);
                  var res = await provider.login();
                  Navigator.pop(context);
                  if(res["code"] == 200){
                    Navigator.pushReplacementNamed(context, "/home");
                  }else{
                    FutureUtils.showAlert(context, dismissible: true, description: res["message"]);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("Iniciar sesión", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 20,),
              ButtonSecondaryComponent(
                onTap: () {  },
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Crear cuenta", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}