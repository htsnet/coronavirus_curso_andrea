import 'package:coronavirus_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker/app/services/api_service.dart';
import 'package:coronavirus_tracker/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app/services/api.dart';

Future<void> main() async {
  Intl.defaultLocale = 'pt-BR';
  await initializeDateFormatting();
  runApp(MyApp());
} 
  

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(API.sandbox()),),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}

