import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/prediction_response.dart';

class PieChartWidget extends StatelessWidget {
  final List<FeatureImportance> explanation;

  const PieChartWidget({
    super.key,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    if (explanation.isEmpty) {
      return const SizedBox();
    }

    final colors = [
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.brown,
    ];

    final total = explanation.fold<double>(
      0,
          (sum, item) => sum + item.impact,
    );

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.pie_chart, color: Colors.deepOrange),
                SizedBox(width: 8),
                Text(
                  "Feature Distribution",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 45,
                  sectionsSpace: 3,
                  sections: List.generate(
                    explanation.length,
                        (index) {
                      final item = explanation[index];

                      return PieChartSectionData(
                        color: colors[index % colors.length],
                        value: item.impact,
                        title:
                        "${((item.impact / total) * 100).toStringAsFixed(1)}%",
                        radius: 70,
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Column(
              children: List.generate(
                explanation.length,
                    (index) {
                  final item = explanation[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(item.feature),
                        ),
                        Text(
                          "${((item.impact / total) * 100).toStringAsFixed(1)}%",
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}