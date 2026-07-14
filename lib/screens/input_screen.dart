import 'package:flutter/material.dart';
import '../services/rf_service.dart';
import 'result_screen.dart';
import '../models/crop_model.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});


  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final n = TextEditingController();
  final p = TextEditingController();
  final k = TextEditingController();
  final temp = TextEditingController();
  final hum = TextEditingController();
  final ph = TextEditingController();
  final rain = TextEditingController();

  List<CropResult> predictions = [];

  bool isLoading = false;

  bool validateInput() {
    double? N = double.tryParse(n.text);
    double? P = double.tryParse(p.text);
    double? K = double.tryParse(k.text);
    double? tempVal = double.tryParse(temp.text);
    double? humVal = double.tryParse(hum.text);
    double? phVal = double.tryParse(ph.text);
    double? rainVal = double.tryParse(rain.text);

    if (N == null || N < 0 || N > 140) return false;
    if (P == null || P < 5 || P > 145) return false;
    if (K == null || K < 5 || K > 205) return false;
    if (tempVal == null || tempVal < 8 || tempVal > 44) return false;
    if (humVal == null || humVal < 14 || humVal > 99) return false;
    if (phVal == null || phVal < 3.5 || phVal > 9.9) return false;
    if (rainVal == null || rainVal < 20 || rainVal > 300) return false;

    return true;
  }

  Future<void> predict() async {
    try {
      if (!validateInput()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ইনপুট সঠিক নয় বা সীমার বাইরে")),
        );
        return;
      }

      setState(() => isLoading = true);

      final response = await RecommendationService.getPrediction(
        N: double.parse(n.text),
        P: double.parse(p.text),
        K: double.parse(k.text),
        temperature: double.parse(temp.text),
        humidity: double.parse(hum.text),
        ph: double.parse(ph.text),
        rainfall: double.parse(rain.text),
      );

      setState(() => isLoading = false);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            response: response,
          ),
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Widget field(String label, IconData icon, TextEditingController c, String range) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: "Range (${range.replaceAll("Range: ", "")})",

          prefixIcon: Icon(icon, color: Colors.green),

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF56ab2f), Color(0xFFa8e063)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                "Crop Recommendation",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView(
                    children: [
                      field("নাইট্রোজেন (N)", Icons.science, n, "Range: 0 - 140 kg/ha"),
                      field("ফসফরাস (P)", Icons.science, p, "Range: 5 - 145 kg/ha"),
                      field("পটাশিয়াম (K)", Icons.science, k, "Range: 5 - 205 kg/ha"),
                      field("তাপমাত্রা", Icons.thermostat, temp, "Range: 8 - 44 C"),
                      field("আদ্রতা", Icons.water_drop, hum, "Range: 14 - 99 %"),
                      field("pH মান", Icons.grass, ph, "Range: 3.5 - 9.9"),
                      field("বৃষ্টিপাত", Icons.cloud, rain, "Range: 20 - 300 mm"),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: predict,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.green,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.agriculture, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "ফসল দেখুন",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              //
              // const Text(
              //   "Developed by S.k Shuvo",
              //   style: TextStyle(
              //     fontSize: 14,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //     fontStyle: FontStyle.italic,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}