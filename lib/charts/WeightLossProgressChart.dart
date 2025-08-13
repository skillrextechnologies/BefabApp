import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class WeightLossProgressChart extends StatelessWidget {
  const WeightLossProgressChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weight Loss Progress',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000000),
                ),
              ),
              Icon(Icons.keyboard_arrow_up, color: Colors.grey[600], size: 24),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: false,
                  verticalInterval: 1,
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300]!,
                      strokeWidth: 1,
                      dashArray: [3, 3],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('', style: style);
                            break;
                          case 1:
                            text = const Text('Aug', style: style);
                            break;
                          case 2:
                            text = const Text('Sep', style: style);
                            break;
                          case 3:
                            text = const Text('Oct', style: style);
                            break;
                          case 4:
                            text = const Text('Nov', style: style);
                            break;
                          case 5:
                            text = const Text('', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          meta: meta, // pass the whole meta, not just axisSide
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: const Padding(
                      padding: EdgeInsets.only(bottom: 180, right: 10),
                      child: Text(
                        'kg',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        );
                        // Show values: 40, 50, 60, 70
                        if (value == 40 ||
                            value == 50 ||
                            value == 60 ||
                            value == 70) {
                          return Text(value.toInt().toString(), style: style);
                        }
                        return const Text('');
                      },
                      reservedSize: 32,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    left: BorderSide(color: Colors.black87, width: 1),
                    bottom: BorderSide(color: Colors.black87, width: 1),
                    right: BorderSide.none,
                    top: BorderSide.none,
                  ),
                ),
                minX: 0,
                maxX: 5,
                minY: 40,
                maxY: 70,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 49), // Starting point (July)
                      FlSpot(1, 59), // Aug
                      FlSpot(2, 53), // Sep
                      FlSpot(3, 65), // Oct
                      FlSpot(4, 68), // Nov (peak)
                      FlSpot(5, 59), // End point
                    ],
                    isCurved: true,
                    curveSmoothness: 0.4,
                    color: const Color(0xFF8B1538), // Dark red/maroon color
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFF8B1538),
                          strokeWidth: 0,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                lineTouchData: LineTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
