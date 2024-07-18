import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saglik_takip_v2/provider/health_data_provider.dart';
import 'package:saglik_takip_v2/views/health_tracking_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HealthDataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HealthTrackingScreen(),
    );
  }
}
