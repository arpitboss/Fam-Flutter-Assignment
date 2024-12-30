class GradientModel {
  final List<String> colors;
  final double angle;

  GradientModel({
    required this.colors,
    required this.angle,
  });

  factory GradientModel.fromJson(Map<String, dynamic> json) {
    return GradientModel(
      colors: (json['colors'] as List?)?.cast<String>() ?? [],
      angle: json['angle']?.toDouble() ?? 0.0,
    );
  }
}
