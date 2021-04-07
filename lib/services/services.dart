import 'package:pizza_finder/services/consumer.dart';

class Services {
  static String servicesUrl = "https://pizza-finder.herokuapp.com";

  static Future searchPizza({ token, Map query }) async {
    return Consumer.consume(
      url: "$servicesUrl/pizzas" + query.keys.map((key) => "?$key=${query[key]}").toList().join("&"),
      type: ConsumeType.GET,
      token: token
    );
  }

  static Future getPizzaByID({token, id}) async {
    return Consumer.consume(
      url: "$servicesUrl/user/$id",
      token: token
    );
  }

  static Future signIn({user, password}) async {
    return await Consumer.consume(
      url: "$servicesUrl/user",
      body: {        
        "email": user,
        "password": password,
      }
    );
  }
}