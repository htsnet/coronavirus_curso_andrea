import 'package:coronavirus_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/ui/endpoint_card.dart';
import 'package:coronavirus_tracker/app/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpoinstData = await dataRepository.getAllEndpointsData();
    setState(() {
      _endpointsData = endpoinstData;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdateFormatter(
      lastUpdated: _endpointsData != null ? _endpointsData.values[EndPoint.cases].date : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
          onRefresh: _updateData,
        child: ListView(
            children: <Widget>[
      LastUpdatedStatusText(
        text: formatter.lastUpdatedStatusText(),
      ),
      for (var endpoint in EndPoint.values)
      EndpointCard(
        endpoint: endpoint,
        value: _endpointsData != null ? _endpointsData.values[endpoint].value : null,
      ),
            ],
          ),
        ),
    );
  }
}
