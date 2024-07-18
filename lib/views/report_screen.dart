import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saglik_takip_v2/provider/health_data_provider.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final healthData = Provider.of<HealthDataProvider>(context).data;

    return Scaffold(
      appBar: AppBar(
        title: Text('Health Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: healthData.length,
          itemBuilder: (context, index) {
            final data = healthData[index];
            return Card(
              child: ListTile(
                title: Text('Date: ${data.date.toLocal()}'.split(' ')[0]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Steps: ${data.steps}'),
                    Text('Calories: ${data.calories}'),
                    Text('Heart Rate: ${data.heartRate}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
