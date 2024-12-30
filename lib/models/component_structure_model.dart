class ComponentStructure {
  final String type;
  final Map<String, dynamic> properties;

  ComponentStructure({
    required this.type,
    required this.properties,
  });

  factory ComponentStructure.fromJson(Map<String, dynamic> json) =>
      ComponentStructure(
        type: json["type"],
        properties: json["properties"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties,
      };
}
