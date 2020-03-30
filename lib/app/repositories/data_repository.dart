import 'package:coronavirus_tracker/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/api_service.dart';
import 'package:coronavirus_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;

  String _accessToken;

  Future<EndpointData> getEndpointData(EndPoint endpoint) async => 
    await _getDataRefreshingToken<EndpointData>(
      onGetData: () => apiService.getEndpointData(
        accessToken: _accessToken, endpoint: endpoint,
        )
    );

  Future<EndpointsData> getAllEndpointsData() async => 
    await _getDataRefreshingToken<EndpointsData>(
      onGetData: _getAllEndpointsData,
    );

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return onGetData();
      }
      rethrow;
    }
  }



  Future<EndpointsData> _getAllEndpointsData() async {
    final values = await Future.wait(
      [
        apiService.getEndpointData(accessToken: _accessToken, endpoint: EndPoint.cases),
        apiService.getEndpointData(accessToken: _accessToken, endpoint: EndPoint.casesSuspected),
        apiService.getEndpointData(accessToken: _accessToken, endpoint: EndPoint.casesConfirmed),
        apiService.getEndpointData(accessToken: _accessToken, endpoint: EndPoint.deaths),
        apiService.getEndpointData(accessToken: _accessToken, endpoint: EndPoint.recovered),
      ]
    );
    return EndpointsData(values: {
      EndPoint.cases: values[0],
      EndPoint.casesSuspected: values[1],
      EndPoint.casesConfirmed: values[2],
      EndPoint.deaths: values[3],
      EndPoint.recovered: values[4],
    });
  }
}
