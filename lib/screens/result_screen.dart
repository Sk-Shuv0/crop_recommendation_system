import 'package:flutter/material.dart';
import 'package:crop_recommendation_system/services/crop_info_service.dart';
import 'package:crop_recommendation_system/models/crop_info.dart';

class ResultScreen extends StatefulWidget {
  final String cropName;

  const ResultScreen({Key? key, required this.cropName}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getCropImage(String name) {
    return "assets/images/${name.toLowerCase()}.png";
  }

  @override
  Widget build(BuildContext context) {

    CropInfo? info =
    CropInfoService.getInfo(widget.cropName);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendation Result 🌾"),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                getCropImage(widget.cropName),
                height: 180,
              ),

              const SizedBox(height: 20),

              Text(
                widget.cropName.toUpperCase(),
                style: const TextStyle(
                  fontSize: 30,

                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 25),

              if (info != null) ...[

                _buildCard("Description", info.description),
                _buildCard("Suitable Season", info.season),
                _buildCard("Soil Type", info.soil),

              ] else ...[
                const Text("No additional information available.")
              ],

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Try Again"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
