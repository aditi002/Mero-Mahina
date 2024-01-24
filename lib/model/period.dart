class Period {
  DateTime from;
  DateTime to;
  int bloodIndex;
  int painIndex;

  Period({
    required this.from,
    required this.to,
    required this.bloodIndex,
    required this.painIndex,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      from: json['from'] != null ? DateTime.parse(json['from']) : DateTime.now(),
      to: json['to'] != null ? DateTime.parse(json['to']) : DateTime.now(),
      bloodIndex: json['blood'] ?? 0,
      painIndex: json['pain'] ?? 0,
    );
  }
}
