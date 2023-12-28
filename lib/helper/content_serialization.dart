import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

Future<String> serializeContent(ResponseType type, dynamic content) async {
  switch (type) {
    case ResponseType.plain:
      return content;
    case ResponseType.json:
      return jsonEncode(content);
    default:
      throw UnsupportedError('Response type not supported : $type.');
  }
}

dynamic deserializeContent(ResponseType type, String? content) {
  switch (type) {
    case ResponseType.plain:
      return (content != null) ? content : null;
    case ResponseType.json:
      return (content != null) ? jsonDecode(content) : null;
    default:
      throw UnsupportedError('Response type not supported : $type.');
  }
}
