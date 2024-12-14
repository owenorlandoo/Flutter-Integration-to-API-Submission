import 'dart:async';
import 'dart:convert';
import 'package:mvvm/shared/shared.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices {
  Future<dynamic> getApiResponse(String endpoint) async {
    try {
      final url = Uri.parse("${Const.baseUrl}/$endpoint");
      print("Requesting URL: $url"); // Debug log
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      });
      return returnResponse(response);
    } catch (e) {
      throw Exception("Error in getApiResponse: $e");
    }
  }

  Future<dynamic> postApiResponse(String endpoint, Map<String, dynamic> data) async {
  try {
    final url = Uri.parse("${Const.baseUrl}/$endpoint");
    print("Requesting URL: $url");
    print("Request Payload: $data");
    print("API Key: ${Const.apiKey}");
    final response = await http.post(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'key': Const.apiKey,
    }, body: data);
    return returnResponse(response);
  } catch (e) {
    throw Exception("Error in postApiResponse: $e");
  }
}


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 404:
        throw Exception("Error 404: Endpoint not found");
      default:
        throw Exception("Error: ${response.statusCode}, ${response.body}");
    }
  }
}
