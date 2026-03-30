import 'package:flutter/material.dart';
import 'package:crop_recommendation_system/models/crop_model.dart';
import 'package:crop_recommendation_system/services/csv_services.dart';
import 'package:crop_recommendation_system/services/recommendation_service.dart';
import 'package:crop_recommendation_system/screens/result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController rainController = TextEditingController();

  final CsvService _csvService = CsvService();
  final RecommendationService _recommendationService = RecommendationService();

  bool _isLoading = false;

  @override
  void dispose() {
    nController.dispose();
    pController.dispose();
    kController.dispose();
    tempController.dispose();
    humidityController.dispose();
    phController.dispose();
    rainController.dispose();
    super.dispose();
  }

  Future<void> _handleRecommendation() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus(); // keyboard hide

    setState(() => _isLoading = true);

    final crops = await _csvService.loadCrops();

    CropModel input = CropModel(
      n: double.parse(nController.text),
      p: double.parse(pController.text),
      k: double.parse(kController.text),
      temperature: double.parse(tempController.text),
      humidity: double.parse(humidityController.text),
      ph: double.parse(phController.text),
      rainfall: double.parse(rainController.text),
      label: "",
    );

    String result =
    _recommendationService.recommendCrop(crops, input);

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("সফলভাবে সুপারিশ তৈরি হয়েছে 🌾"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(cropName: result),
      ),
    );
  }

  void _clearFields() {
    nController.clear();
    pController.clear();
    kController.clear();
    tempController.clear();
    humidityController.clear();
    phController.clear();
    rainController.clear();
  }

  Widget _buildInputField(
      String label,
      String hint,
      TextEditingController controller,
      TextInputAction action,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        textInputAction: action,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label লিখুন";
          }
          if (double.tryParse(value) == null) {
            return "সঠিক সংখ্যা লিখুন";
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Recommendation System", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30, ),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [

              _buildInputField("নাইট্রোজেন (N)", "উদাহরণ: 90", nController, TextInputAction.next),
              _buildInputField("ফসফরাস (P)", "উদাহরণ: 40", pController, TextInputAction.next),
              _buildInputField("পটাশিয়াম (K)", "উদাহরণ: 45", kController, TextInputAction.next),
              _buildInputField("তাপমাত্রা (°C)", "উদাহরণ: 25", tempController, TextInputAction.next),
              _buildInputField("আর্দ্রতা (%)", "উদাহরণ: 80", humidityController, TextInputAction.next),
              _buildInputField("মাটির pH", "উদাহরণ: 6.5", phController, TextInputAction.next),
              _buildInputField("বৃষ্টিপাত (mm)", "উদাহরণ: 200", rainController, TextInputAction.done),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRecommendation,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "সুপারিশ দেখুন",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
