class CropResult {
  final String crop;
  final double confidence;

  CropResult({required this.crop, required this.confidence});

  factory CropResult.fromJson(Map<String, dynamic> json) {
    return CropResult(
      crop: json['crop'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}