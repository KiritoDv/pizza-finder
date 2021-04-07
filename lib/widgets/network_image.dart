import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageUtils {

  static Map<String, ImageProvider> cache = Map();

  static Future<ImageProvider> fetchImage( fallback, url ) async {    
    if(cache.containsKey(url)) return cache[url];

    var img = fallback;

    try {
      var res = await http.get(Uri.parse(url));
      switch(res.statusCode) {
        case 200:
          img = MemoryImage(res.bodyBytes);
          cache.putIfAbsent(url, () => img);
          break;
        case 404:
        case 510:
          img = fallback;
          break;
      }
    } catch ( e ){
      print("There was an error downloading the image");
    }
    return img;
  }
}
