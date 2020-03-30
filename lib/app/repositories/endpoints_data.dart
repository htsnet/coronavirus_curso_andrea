

import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<EndPoint, EndpointData> values;

  EndpointData get cases => values[EndPoint.cases];
  EndpointData get casesSuspected => values[EndPoint.casesSuspected];
  EndpointData get casesConfirmed => values[EndPoint.casesConfirmed];
  EndpointData get deaths => values[EndPoint.deaths];
  EndpointData get recovered => values[EndPoint.recovered];

  @override
  String toString() =>
  'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}