import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:saglik_takip_v2/provider/health_data_provider.dart';

class RaporEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final saglikVerisi = Provider.of<SaglikVeriProvider>(context).veri;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sağlık Raporları'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Adım Grafiği',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: LineChart(
                _buildLineChartData(
                  saglikVerisi
                      .map((veri) => FlSpot(
                          veri.tarih.millisecondsSinceEpoch.toDouble(),
                          veri.adim.toDouble()))
                      .toList(),
                  'Adım',
                ),
              ),
            ),
            Text(
              'Kalori Grafiği',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: LineChart(
                _buildLineChartData(
                  saglikVerisi
                      .map((veri) => FlSpot(
                          veri.tarih.millisecondsSinceEpoch.toDouble(),
                          veri.kalori.toDouble()))
                      .toList(),
                  'Kalori',
                ),
              ),
            ),
            Text(
              'Nabız Grafiği',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: LineChart(
                _buildLineChartData(
                  saglikVerisi
                      .map((veri) => FlSpot(
                          veri.tarih.millisecondsSinceEpoch.toDouble(),
                          veri.nabiz.toDouble()))
                      .toList(),
                  'Nabız',
                ),
              ),
            ),
            Text(
              'Tansiyon Grafiği',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: LineChart(
                _buildLineChartData(
                  saglikVerisi
                      .map((veri) => FlSpot(
                          veri.tarih.millisecondsSinceEpoch.toDouble(),
                          veri.tansiyon.toDouble()))
                      .toList(),
                  'Tansiyon',
                ),
              ),
            ),
            Text(
              'Şeker Seviyesi Grafiği',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: LineChart(
                _buildLineChartData(
                  saglikVerisi
                      .map((veri) => FlSpot(
                          veri.tarih.millisecondsSinceEpoch.toDouble(),
                          veri.sekerSeviyesi.toDouble()))
                      .toList(),
                  'Şeker Seviyesi',
                ),
              ),
            ),
            Text(
              'Kilo Grafiği',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: LineChart(
                _buildLineChartData(
                  saglikVerisi
                      .map((veri) => FlSpot(
                          veri.tarih.millisecondsSinceEpoch.toDouble(),
                          veri.kilo.toDouble()))
                      .toList(),
                  'Kilo',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildLineChartData(List<FlSpot> spots, String yAxisLabel) {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 4,
          color: Colors.blue,
          dotData: FlDotData(show: false),
        ),
      ],
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) {
              final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  '${date.day}/${date.month}',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: TextStyle(color: Colors.black, fontSize: 10),
              );
            },
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black, width: 1),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.black, strokeWidth: 0.5);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.black, strokeWidth: 0.5);
        },
      ),
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(),
      ),
    );
  }
}
