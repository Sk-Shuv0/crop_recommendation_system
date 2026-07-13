import 'package:flutter/material.dart';
import '../models/crop_model.dart';
import '../models/prediction_response.dart';
import '../widgets/feature_importance_card.dart';
import '../widgets/pie_chart_widget.dart';
import '../widgets/ai_explanation_card.dart';

class ResultScreen extends StatelessWidget {
  final PredictionResponse response;

  const ResultScreen({
    super.key,
    required this.response,
  });

  List<CropResult> get results => response.results;

  List<FeatureImportance> get explanation => response.explanation;

  String getImage(String crop) => "assets/images/$crop.png";

  String getDescription(String crop) {
    switch (crop.toLowerCase()) {

      case "apple":
        return "আপেল একটি উচ্চমূল্যের ফল যা সাধারণত শীতল ও নাতিশীতোষ্ণ আবহাওয়ায় ভালো জন্মে। "
            "এটির জন্য ভালো নিষ্কাশনযুক্ত দোআঁশ মাটি প্রয়োজন এবং pH 6.0–7.0 হলে সর্বোত্তম ফলন পাওয়া যায়। "
            "নিয়মিত সেচ, সার প্রয়োগ এবং রোগবালাই নিয়ন্ত্রণের মাধ্যমে উৎপাদন বৃদ্ধি করা যায়। "
            "আপেল ভিটামিন C, ফাইবার ও অ্যান্টিঅক্সিডেন্টে সমৃদ্ধ হওয়ায় এটি স্বাস্থ্যসম্মত ফল।";

      case "banana":
        return "কলা একটি দ্রুত বর্ধনশীল ও অর্থনৈতিকভাবে লাভজনক ফল। "
            "এটি উষ্ণ ও আর্দ্র জলবায়ুতে ভালো জন্মে এবং জৈব পদার্থসমৃদ্ধ মাটিতে উচ্চ ফলন দেয়। "
            "পর্যাপ্ত সেচ, নাইট্রোজেন সার এবং আগাছা নিয়ন্ত্রণের মাধ্যমে উৎপাদন বৃদ্ধি সম্ভব। "
            "কলায় পটাশিয়াম ও কার্বোহাইড্রেট বেশি থাকায় এটি শক্তির ভালো উৎস।";

      case "blackgram":
        return "কালো মুগ একটি গুরুত্বপূর্ণ ডাল ফসল যা মাটির উর্বরতা বৃদ্ধি করে কারণ এটি নাইট্রোজেন স্থির করে। "
            "এটি উষ্ণ ও শুষ্ক আবহাওয়ায় ভালো জন্মে এবং কম পানিতে চাষ করা যায়। "
            "ডাল হিসেবে এটি প্রোটিনের একটি গুরুত্বপূর্ণ উৎস এবং ফসল চক্রে ব্যবহার করলে মাটির গুণাগুণ উন্নত হয়।";

      case "chickpea":
        return "ছোলা একটি শীতকালীন ডাল ফসল যা কম পানিতে চাষ করা যায় এবং দোআঁশ মাটিতে ভালো ফলন দেয়। "
            "এতে উচ্চমাত্রার প্রোটিন ও খনিজ উপাদান রয়েছে। "
            "সঠিক বপন সময়, আগাছা নিয়ন্ত্রণ ও রোগ ব্যবস্থাপনার মাধ্যমে উৎপাদন বৃদ্ধি করা যায়।";

      case "coconut":
        return "নারিকেল একটি বহুমুখী ও দীর্ঘমেয়াদী অর্থকরী ফসল যা উপকূলীয় ও উষ্ণ অঞ্চলে ভালো জন্মে। "
            "এটির জন্য বেলে দোআঁশ মাটি ও পর্যাপ্ত বৃষ্টিপাত প্রয়োজন। "
            "নারিকেল থেকে তেল, পানি ও বিভিন্ন খাদ্যপণ্য তৈরি করা হয়।";

      case "coffee":
        return "কফি একটি উচ্চমূল্যের বাণিজ্যিক ফসল যা শীতল ও উচ্চভূমিতে ভালো জন্মে। "
            "ছায়াযুক্ত পরিবেশ, জৈব পদার্থসমৃদ্ধ মাটি এবং সুষম বৃষ্টিপাত এর জন্য প্রয়োজনীয়। "
            "বিশ্ববাজারে কফির চাহিদা বেশি হওয়ায় এটি লাভজনক ফসল।";

      case "cotton":
        return "কাপাস একটি গুরুত্বপূর্ণ শিল্প ফসল যা বস্ত্র শিল্পের মূল কাঁচামাল। "
            "এটি উষ্ণ ও শুষ্ক আবহাওয়ায় ভালো জন্মে এবং গভীর দোআঁশ মাটিতে ভালো ফলন দেয়। "
            "সঠিক সার প্রয়োগ ও কীটনাশক ব্যবস্থাপনার মাধ্যমে উৎপাদন বৃদ্ধি সম্ভব।";

      case "grapes":
        return "আঙুর একটি উচ্চমূল্যের ফল যা শুষ্ক ও উষ্ণ আবহাওয়ায় ভালো জন্মে। "
            "ভালো নিষ্কাশনযুক্ত মাটি ও পর্যাপ্ত সূর্যালোক এর জন্য প্রয়োজন। "
            "এটি ভিটামিন ও মিনারেলে সমৃদ্ধ এবং জুস, ওয়াইন ও কিসমিস তৈরিতে ব্যবহৃত হয়।";

      case "jute":
        return "পাট বাংলাদেশের একটি প্রধান অর্থকরী ফসল যা গরম ও আর্দ্র পরিবেশে ভালো জন্মে। "
            "পানিযুক্ত জমি ও পলি মাটি এর জন্য উপযোগী। "
            "পাট থেকে দড়ি, বস্তা ও পরিবেশবান্ধব পণ্য তৈরি করা হয়।";

      case "kidneybeans":
        return "রাজমা একটি পুষ্টিকর ডাল ফসল যা শীতল আবহাওয়ায় ভালো জন্মে। "
            "এতে উচ্চমাত্রার প্রোটিন, ফাইবার ও খনিজ উপাদান রয়েছে। "
            "এটি দোআঁশ মাটিতে ভালো ফলন দেয়।";

      case "lentil":
        return "মসুর ডাল একটি জনপ্রিয় শীতকালীন ফসল যা কম পানিতে চাষ করা যায়। "
            "এতে প্রোটিন, আয়রন ও ভিটামিন রয়েছে। "
            "মাটির উর্বরতা বৃদ্ধি করতেও এটি সহায়ক।";

      case "maize":
        return "ভুট্টা একটি বহুমুখী ফসল যা খাদ্য, পশুখাদ্য ও শিল্পে ব্যবহৃত হয়। "
            "এটি বিভিন্ন ধরনের মাটিতে জন্মাতে পারে এবং মাঝারি তাপমাত্রায় ভালো ফলন দেয়।";

      case "mango":
        return "আম একটি জনপ্রিয় ও অর্থকরী ফল যা উষ্ণ আবহাওয়ায় ভালো জন্মে। "
            "ভালো নিষ্কাশনযুক্ত মাটি ও পর্যাপ্ত সূর্যালোক প্রয়োজন। "
            "এটি ভিটামিন A ও C সমৃদ্ধ।";

      case "mungbean":
        return "মুগ ডাল একটি স্বল্পমেয়াদী ফসল যা দ্রুত উৎপাদন দেয়। "
            "এটি মাটির উর্বরতা বৃদ্ধি করে এবং প্রোটিনের ভালো উৎস।";

      case "orange":
        return "কমলা একটি ভিটামিন C সমৃদ্ধ ফল যা শীতল আবহাওয়ায় ভালো জন্মে। "
            "এটি রোগ প্রতিরোধ ক্ষমতা বাড়ায় এবং উচ্চমূল্যের ফল।";

      case "papaya":
        return "পেঁপে একটি দ্রুত বর্ধনশীল ফল যা সারা বছর উৎপাদন সম্ভব। "
            "এটি হজমে সাহায্য করে এবং ভিটামিন সমৃদ্ধ।";

      case "rice":
        return "ধান বাংলাদেশের প্রধান খাদ্যশস্য যা পানিযুক্ত জমিতে ভালো জন্মে। "
            "উষ্ণ ও আর্দ্র আবহাওয়া এর জন্য উপযুক্ত। "
            "দেশের খাদ্য নিরাপত্তায় গুরুত্বপূর্ণ ভূমিকা রাখে।";

      case "watermelon":
        return "তরমুজ একটি গ্রীষ্মকালীন ফল যা বেলে মাটিতে ভালো জন্মে। "
            "এতে প্রচুর পানি ও ভিটামিন থাকে এবং গরমে শরীর ঠান্ডা রাখে।";

      default:
        return "এই ফসল সম্পর্কে তথ্য পাওয়া যায়নি।";
    }
  }
  String getBanglaName(String crop) {
    switch (crop.toLowerCase()) {
      case "apple":
        return "আপেল";
      case "banana":
        return "কলা";
      case "blackgram":
        return "কালো মুগ";
      case "chickpea":
        return "ছোলা";
      case "coconut":
        return "নারিকেল";
      case "coffee":
        return "কফি";
      case "cotton":
        return "কাপাস";
      case "grapes":
        return "আঙুর";
      case "jute":
        return "পাট";
      case "kidneybeans":
        return "রাজমা";
      case "lentil":
        return "মসুর ডাল";
      case "maize":
        return "ভুট্টা";
      case "mango":
        return "আম";
      case "mungbean":
        return "মুগ ডাল";
      case "muskmelon":
        return "বাঙ্গি";
      case "orange":
        return "কমলা";
      case "papaya":
        return "পেঁপে";
      case "pigeonpeas":
        return "আরহার ডাল";
      case "pomegranate":
        return "ডালিম";
      case "rice":
        return "ধান";
      case "watermelon":
        return "তরমুজ";
      default:
        return crop;
    }
  }
  String getWhyRecommended(String crop) {
    return "তোমার দেওয়া মাটির উপাদান (NPK), তাপমাত্রা, আর্দ্রতা ও pH অনুযায়ী "
        "$crop চাষের জন্য উপযুক্ত পরিবেশ তৈরি হয়েছে। "
        "এই ফসল এই ধরনের আবহাওয়া ও মাটিতে ভালো ফলন দেয়, তাই এটি সুপারিশ করা হয়েছে।";
  }

  String getSeason(String crop) {
    switch (crop.toLowerCase()) {
      case "rice":
        return "বর্ষা মৌসুম (আষাঢ় - আশ্বিন)";
      case "wheat":
        return "শীতকাল (কার্তিক - মাঘ)";
      case "mango":
        return "গ্রীষ্মকাল";
      case "watermelon":
        return "গ্রীষ্মকাল";
      case "lentil":
        return "শীতকাল";
      default:
        return "স্থানীয় আবহাওয়ার উপর নির্ভরশীল";
    }
  }

  String getFertilizer(String crop) {
    switch (crop.toLowerCase()) {
      case "rice":
        return "ইউরিয়া, টিএসপি ও এমওপি সুষমভাবে প্রয়োগ করতে হবে।";
      case "maize":
        return "নাইট্রোজেন সমৃদ্ধ সার বেশি প্রয়োজন।";
      case "banana":
        return "জৈব সার + পটাশিয়াম বেশি দরকার।";
      case "mango":
        return "জৈব সার ও ফসফরাস প্রয়োগ উপকারী।";
      default:
        return "স্থানীয় কৃষি অফিসের পরামর্শ অনুযায়ী সার ব্যবহার করুন।";
    }
  }
  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(Icons.agriculture, size: 22),
              SizedBox(width: 8),
              Text("ফলাফল"),
            ],
          ),
        ),
        body: Center(child: Text("No data found")),
      );
    }
    final best = results[0];

    Widget buildFeatureImportance() {
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "📊 Feature Importance (XAI)",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              ...explanation.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.feature,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      LinearProgressIndicator(
                        value: e.impact,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(10),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${(e.impact * 100).toStringAsFixed(1)} %",
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.agriculture, size: 22),
            SizedBox(width: 8),
            Text("ফলাফল"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                getImage(best.crop),
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported, size: 100);
                },
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.eco, size: 28, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    getBanglaName(best.crop),
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bar_chart, size: 18),
                  SizedBox(width: 6),
                  Text("ম্যাচ রেট",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Text("${(best.confidence * 100).toStringAsFixed(1)}%"),
          
              const Divider(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.details, size: 18),
                  SizedBox(width: 6),
                  Text("সংক্ষিপ্ত বিবরণ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
          
              Text(
                getDescription(best.crop),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),

              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lightbulb, size: 18),
                  SizedBox(width: 6),
                  Text("কেন এই ফসল সুপারিশ করা হয়েছে ?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Text(
                getWhyRecommended(best.crop),
                textAlign: TextAlign.center,
              ),
              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.wb_sunny, size: 18),
                  SizedBox(width: 6),
                  Text("উপযুক্ত মৌসুম",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Text(getSeason(best.crop)),

              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.grass, size: 18),
                  SizedBox(width: 6),
                  Text("সার প্রয়োগ নির্দেশনা",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Text(getFertilizer(best.crop)),
          
              const Divider(),

              FeatureImportanceCard(
                explanation: explanation,
              ),

              const SizedBox(height: 15),

              PieChartWidget(
                explanation: explanation,
              ),

              const SizedBox(height: 15),

              AIExplanationCard(
                cropName: getBanglaName(best.crop),
                explanation: explanation,
              ),

              const Divider(),

              // buildFeatureImportance(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.trending_up, size: 20),
                  SizedBox(width: 6),
                  Text("সেরা ৩টি সাজেশন",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
          
              ...results.asMap().entries.map((entry) {
                final r = entry.value;
          
                return Card(
                  child: ListTile(
                    leading: Image.asset(getImage(r.crop), width: 40),
                    title: Text(getBanglaName(r.crop)),
                    subtitle: Text(
                        "${(r.confidence * 100).toStringAsFixed(1)}%"),
                    trailing: Text("#${entry.key + 1}"),
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}