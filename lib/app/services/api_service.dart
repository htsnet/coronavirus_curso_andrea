import 'dart:convert';

import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(api.toeknUri().toString(), headers: {
      'Authorization': 'Basic ${api.apiKey}',
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.toeknUri()} failed\nResponse: ${response.statusCode} ');
    throw response;
  }

  Future<EndpointData> getEndpointData(
      {@required String accessToken, @required EndPoint endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http
        .get(uri.toString(), headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint];
        final int value = endpointData[responseJsonKey];
        final String dateString = endpointData['date'];
        final date = DateTime.tryParse(dateString);
        if (value != null) {
          return EndpointData(value: value, date: date);
        }
      }
    }
    print('Request failed\nResponse: ${response.statusCode} ${response.reasonPhrase} $endpoint');
    throw response;
  }

  static Map<EndPoint, String> _responseJsonKeys = {
    EndPoint.cases: 'cases',
    EndPoint.casesConfirmed: 'data',
    EndPoint.casesSuspected: 'data',
    EndPoint.deaths: 'data',
    EndPoint.recovered: 'data',
  };
}
