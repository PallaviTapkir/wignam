import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart' show rootBundle;

class JsonUtils {
  static Future<Map<String, dynamic>> parseJsonFromAssets(String path) async {
    log('Parsing json: $path');
    return rootBundle.loadString(path).then((jsonStr) => jsonDecode(jsonStr));
  }
}
