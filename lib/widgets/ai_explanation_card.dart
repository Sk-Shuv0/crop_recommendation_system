import 'package:flutter/material.dart';
import '../models/prediction_response.dart';

class AIExplanationCard extends StatelessWidget {
  final String cropName;
  final List<FeatureImportance> explanation;

  const AIExplanationCard({
    super.key,
    required this.cropName,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    final top = explanation.take(3).toList();

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
                Icon(Icons.psychology,
                    color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "AI Explanation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            const SizedBox(height: 15),

            Text(
              "$cropName ফসলটি সুপারিশ করা হয়েছে কারণ নিচের বৈশিষ্ট্যগুলো সবচেয়ে বেশি প্রভাব ফেলেছে:",
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 15),

            ...top.map(
                  (e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${e.feature} (${(e.impact * 100).toStringAsFixed(2)}%)",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Divider(),

            const Text(
              "এই সিদ্ধান্তটি Random Forest Model এবং Explainable AI (XAi)-এর ভিত্তিতে তৈরি করা হয়েছে।",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
    );
  }
}