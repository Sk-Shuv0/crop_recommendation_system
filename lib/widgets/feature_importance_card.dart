import 'package:flutter/material.dart';
import '../models/prediction_response.dart';

class FeatureImportanceCard extends StatelessWidget {
  final List<FeatureImportance> explanation;

  const FeatureImportanceCard({
    super.key,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    final maxImpact = explanation.isEmpty
        ? 1.0
        : explanation
        .map((e) => e.impact)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [
                Icon(Icons.bar_chart,
                    color: Colors.green),
                SizedBox(width: 8),
                Text(
                  "Feature Importance (XAI)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ...explanation.map((e) {

              final percent = maxImpact == 0
                  ? 0.0
                  : e.impact / maxImpact;

              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            e.feature,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "${(e.impact * 100).toStringAsFixed(2)}%",
                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 8),

                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: percent,
                        minHeight: 12,
                        backgroundColor:
                        Colors.grey.shade300,
                        valueColor:
                        const AlwaysStoppedAnimation(
                          Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}