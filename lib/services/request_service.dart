import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestService {
  /*
    Makes a post request to the backend
    @param url: The url of the endpoint
    @param body: The body of the request
    @param headers: The headers of the request
    @return: The response of the request
    @return: The body of the request
  */
  Future<Map<String, dynamic>> postRequest(
      String url, dynamic body, dynamic headers) async {
    final uri = Uri.parse(url);
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    Map<String, dynamic> bodyReturned;
    try {
      bodyReturned = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      bodyReturned = {};
    }
    return {
      "error": response.body,
      "body": bodyReturned,
      "status_code": response.statusCode
    };
  }

  Future<Map<String, dynamic>> getRequest(String url,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);
    debugPrint("Response: ${response.statusCode}");
    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    Map<String, dynamic> bodyReturned;
    try {
      bodyReturned = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      bodyReturned = {};
    }
    return {
      "error": response.body,
      "body": bodyReturned,
      "status_code": response.statusCode
    };
  }

  Future<Map<String, dynamic>> patchRequest(
      String url, dynamic body, dynamic headers) async {
    final uri = Uri.parse(url);
    final response =
        await http.patch(uri, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    Map<String, dynamic> bodyReturned;
    try {
      bodyReturned = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      bodyReturned = {};
    }
    return {
      "error": response.body,
      "body": bodyReturned,
      "status_code": response.statusCode
    };
  }

  Future<Map<String, dynamic>> putRequest(
      String url, dynamic body, dynamic headers) async {
    final uri = Uri.parse(url);
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    Map<String, dynamic> bodyReturned;
    try {
      bodyReturned = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      bodyReturned = {};
    }
    return {
      "error": response.body,
      "body": bodyReturned,
      "status_code": response.statusCode
    };
  }

  Future<Map<String, dynamic>> deleteRequest(
      String url, dynamic body, dynamic headers) async {
    final uri = Uri.parse(url);
    final response =
        await http.delete(uri, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    Map<String, dynamic> bodyReturned;
    try {
      bodyReturned = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      bodyReturned = {};
    }
    return {
      "error": response.body,
      "body": bodyReturned,
      "status_code": response.statusCode
    };
  }
}
