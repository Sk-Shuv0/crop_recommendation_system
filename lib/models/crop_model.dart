class CropModel {
  final double n;
  final double p;
  final double k;
  final double temperature;
  final double humidity;
  final double ph;
  final double rainfall;
  final String label;

  CropModel({
    required this.n,
    required this.p,
    required this.k,
    required this.temperature,
    required this.humidity,
    required this.ph,
    required this.rainfall,
    required this.label,
  });

  factory CropModel.fromList(List<dynamic> row) {
    return CropModel(
      n: row[0].toDouble(),
      p: row[1].toDouble(),
      k: row[2].toDouble(),
      temperature: row[3].toDouble(),
      humidity: row[4].toDouble(),
      ph: row[5].toDouble(),
      rainfall: row[6].toDouble(),
      label: row[7].toString(),
    );
  }
}
