import 'package:flutter/foundation.dart';
import 'package:saglik_takip_v2/models/health_data.dart'; // Sağlık verisi modelini içe aktarıyoruz

// Sağlık verilerini sağlayan ve yöneten sınıf
class SaglikVeriProvider with ChangeNotifier {
  // Özel sağlık verisi listesi
  List<SaglikVerisi> _veri = [];

  // Sağlık verilerini dışa aktaran getter
  List<SaglikVerisi> get veri => _veri;

  // Yeni sağlık verisi ekleyen yöntem
  void veriEkle(SaglikVerisi yeniVeri) {
    _veri.add(yeniVeri); // Yeni veriyi listeye ekliyoruz
    notifyListeners(); // Değişiklik olduğunu dinleyicilere bildiriyoruz
  }

  // Belirli bir indeksteki sağlık verisini güncelleyen yöntem
  void veriGuncelle(int indeks, SaglikVerisi guncelVeri) {
    _veri[indeks] = guncelVeri; // Belirtilen indeksteki veriyi güncelliyoruz
    notifyListeners(); // Değişiklik olduğunu dinleyicilere bildiriyoruz
  }

  // Belirli bir indeksteki sağlık verisini silen yöntem
  void veriSil(int indeks) {
    _veri.removeAt(indeks); // Belirtilen indeksteki veriyi listeden siliyoruz
    notifyListeners(); // Değişiklik olduğunu dinleyicilere bildiriyoruz
  }
}
