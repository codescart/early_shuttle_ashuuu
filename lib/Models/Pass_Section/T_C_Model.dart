class PassT_C {
  final String cond1;
  final String cond2;
  final String cond3;
  final String cond4;

  PassT_C({
    required this.cond1,
    required this.cond2,
    required this.cond3,
    required this.cond4,
  });

  factory PassT_C.fromJson(Map<String, dynamic> json) {
    return PassT_C(
      cond1: json['1'],
      cond2: json['2'],
      cond3: json['3'],
      cond4: json['4'],
    );
  }
}





