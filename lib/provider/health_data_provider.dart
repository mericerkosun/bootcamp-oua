import 'package:flutter/foundation.dart';
import 'package:saglik_takip_v2/models/health_data.dart';

class HealthDataProvider with ChangeNotifier {
  List<HealthData> _data = [];

  List<HealthData> get data => _data;

  void addData(HealthData newData) {
    _data.add(newData);
    notifyListeners();
  }

  void updateData(int index, HealthData updatedData) {
    _data[index] = updatedData;
    notifyListeners();
  }

  void deleteData(int index) {
    _data.removeAt(index);
    notifyListeners();
  }
}
