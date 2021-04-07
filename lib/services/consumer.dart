import 'dart:async';
import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;

enum ConsumeType {
  POST, GET
}
class Consumer {

  static Future consume({url, body, token, Map<String, String> headers, type = ConsumeType.POST}) async {
    var uri = Uri.parse(url);
    Map<String, String> header = {
      "Content-Type": "application/json;charset=UTF-8",
      if(token != null) 
        HttpHeaders.authorizationHeader: "Bearer $token"
    };

    if(headers != null) header.addAll(headers);

    var response = await (
      type == ConsumeType.POST ? 
        http.post(
          uri,
          body: json.encode(body),
          headers: header
        ) : http.get(
          uri,
          headers: header
        )
      );

    return response;
  }
}
