import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saglik_takip_v2/models/health_data.dart';
import 'package:saglik_takip_v2/provider/health_data_provider.dart';
import 'report_screen.dart';

class HealthTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: HealthDataList(),
          ),
          AddHealthDataForm(),
        ],
      ),
    );
  }
}

class HealthDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final healthData = Provider.of<HealthDataProvider>(context).data;

    return ListView.builder(
      itemCount: healthData.length,
      itemBuilder: (context, index) {
        final data = healthData[index];
        return ListTile(
          title: Text('Steps: ${data.steps}'),
          subtitle:
              Text('Calories: ${data.calories}, Heart Rate: ${data.heartRate}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        EditHealthDataForm(index: index, data: data),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Provider.of<HealthDataProvider>(context, listen: false)
                      .deleteData(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddHealthDataForm extends StatefulWidget {
  @override
  _AddHealthDataFormState createState() => _AddHealthDataFormState();
}

class _AddHealthDataFormState extends State<AddHealthDataForm> {
  final _formKey = GlobalKey<FormState>();
  final _stepsController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _heartRateController = TextEditingController();

  @override
  void dispose() {
    _stepsController.dispose();
    _caloriesController.dispose();
    _heartRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _stepsController,
              decoration: InputDecoration(labelText: 'Steps'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter steps';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter calories';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _heartRateController,
              decoration: InputDecoration(labelText: 'Heart Rate'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter heart rate';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  final newHealthData = HealthData(
                    DateTime.now(),
                    int.parse(_stepsController.text),
                    int.parse(_caloriesController.text),
                    int.parse(_heartRateController.text),
                  );
                  Provider.of<HealthDataProvider>(context, listen: false)
                      .addData(newHealthData);
                }
              },
              child: Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditHealthDataForm extends StatefulWidget {
  final int index;
  final HealthData data;

  EditHealthDataForm({required this.index, required this.data});

  @override
  _EditHealthDataFormState createState() => _EditHealthDataFormState();
}

class _EditHealthDataFormState extends State<EditHealthDataForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _stepsController;
  late TextEditingController _caloriesController;
  late TextEditingController _heartRateController;

  @override
  void initState() {
    _stepsController =
        TextEditingController(text: widget.data.steps.toString());
    _caloriesController =
        TextEditingController(text: widget.data.calories.toString());
    _heartRateController =
        TextEditingController(text: widget.data.heartRate.toString());
    super.initState();
  }

  @override
  void dispose() {
    _stepsController.dispose();
    _caloriesController.dispose();
    _heartRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Health Data'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _stepsController,
              decoration: InputDecoration(labelText: 'Steps'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter steps';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter calories';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _heartRateController,
              decoration: InputDecoration(labelText: 'Heart Rate'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter heart rate';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              final updatedData = HealthData(
                widget.data.date,
                int.parse(_stepsController.text),
                int.parse(_caloriesController.text),
                int.parse(_heartRateController.text),
              );
              Provider.of<HealthDataProvider>(context, listen: false)
                  .updateData(widget.index, updatedData);
              Navigator.of(context).pop();
            }
          },
          child: Text('Update Data'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
