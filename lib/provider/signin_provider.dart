import 'dart:convert';

import 'package:pizza_finder/local/db.dart';
import 'package:pizza_finder/models/user_model.dart';
import 'package:pizza_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignInProvider extends ChangeNotifier{

  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future login() async{
      Response response = await Services.signIn(user: emailController.text, password: passwordController.text);

      if(response.statusCode == 200){
        print(UserModel.fromJson(json.decode(response.body)["data"]).toJson());
        var user = await LocalData.db.createUser(UserModel.fromJson(json.decode(response.body)["data"]));

        if(user != null) return { "code": 200 };
        else
          return {
            "code": 404,
            "message": "Invalid Data"
          };
      }
      return {
        "code": 500,
        "message": "Internal error - try again later."
      };
  }

  authenticate() async{
    UserModel model = LocalData.user;
    return model != null;
  }
}