class GradientModel {
  final double angle;
  final List<String> colors;

  GradientModel({
    required this.angle,
    required this.colors,
  });

  factory GradientModel.fromJson(Map<String, dynamic> json) {
    return GradientModel(
      angle: (json['angle'] as num?)?.toDouble() ?? 0.0,
      colors:
          (json['colors'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        "angle": angle,
        "colors": List<dynamic>.from(colors.map((x) => x)),
      };
}
