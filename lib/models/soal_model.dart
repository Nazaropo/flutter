class Soal {
  final String id;
  final String soal;
  final String kategory;
  final List<String> pilihan;
  final int jawaban;

  Soal({
    required this.kategory,
    required this.id,
    required this.soal,
    required this.pilihan,
    required this.jawaban,
  });

  Map<String, dynamic> toJson() {
    return {
      'kategory': kategory,
      'id': id,
      'soal': soal,
      'pilihan': pilihan,
      'jawaban': jawaban,
    };
  }

  factory Soal.fromJson(Map<String, dynamic> json) {
    return Soal(
      kategory: json['kategory'],
      id: json['id'],
      soal: json['soal'],
      pilihan: json['pilihan'],
      jawaban: json['jawaban'],
    );
  }
}
