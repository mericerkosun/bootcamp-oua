import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saglik_takip_v2/provider/health_data_provider.dart'; // Sağlık verisi sağlayıcısını içe aktarıyoruz
import 'package:saglik_takip_v2/views/health_tracking_screen.dart'; // Sağlık takip ekranını içe aktarıyoruz

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SaglikVeriProvider(),
      child: BenimUygulamam(),
    ),
  );
}

class BenimUygulamam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sağlık Takip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Temel renk ayarları
      ),
      home:
          SaglikTakipEkrani(), // Ana ekran olarak sağlık takip ekranını belirliyoruz
    );
  }
}
