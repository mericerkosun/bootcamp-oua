import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saglik_takip_v2/provider/health_data_provider.dart';

class RaporEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final saglikVerisi = Provider.of<SaglikVeriProvider>(context).veri;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sağlık Raporu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: saglikVerisi.length,
          itemBuilder: (context, index) {
            final veri = saglikVerisi[index];
            final formattedDate =
                "${veri.tarih.day}/${veri.tarih.month}/${veri.tarih.year}"; // Tarihi formatlıyoruz

            return Card(
              child: ListTile(
                title: Text('Tarih: $formattedDate'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Adım: ${veri.adim}'),
                    Text('Kalori: ${veri.kalori}'),
                    Text('Nabız: ${veri.nabiz}'),
                    Text('Tansiyon: ${veri.tansiyon}'),
                    Text('Şeker Seviyesi: ${veri.sekerSeviyesi}'),
                    Text('Kilo: ${veri.kilo}'),
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
