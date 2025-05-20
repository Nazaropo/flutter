import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application/model_soal.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class KuisSceen extends StatefulWidget {
  const KuisSceen({super.key});

  @override
  State<KuisSceen> createState() => _KuisSceenState();
}

class _KuisSceenState extends State<KuisSceen>
    with SingleTickerProviderStateMixin {
  int currentSoalIndex = 0;
  int score = 0;
  bool isAnswered = false;
  int? selectedAnswer;
  int timeLeft = 30;
  Timer? timer;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Color> optionColors = [
    Color(0xffff6b6b),
    Color(0xff4ecdc4),
    Color(0xffffbe0b),
    Color(0xff96e1d3),
  ];
  final List<Soal> soals = [
    Soal(
      soal: "Rukun Islam yang keempat adalah",
      pilihan: [
        "Mengucapkan dua kalimat syahadat",
        "Melaksanakan salat lima waktu",
        "Menunaikan zakat",
        "Berpuasa di bulan Ramadan",
      ],
      jawaban: 3,
    ),
    Soal(
      soal: "Kitab suci yang diturunkan kepada Nabi Musa a.s. adalah",
      pilihan: ["Injil", "Taurat", "Zabur", "Al-Qur’an"],
      jawaban: 1,
    ),
    Soal(
      soal: "Arti dari (Al-Amin), julukan Nabi Muhammad SAW adalah",
      pilihan: ["Yang kuat", "Yang sabar", "Yang terpercaya", "Yang jujur"],
      jawaban: 2,
    ),
    Soal(
      soal:
          "Ibadah yang hanya bisa dilakukan di bulan Dzulhijjah dan di Mekkah adalah",
      pilihan: ["Salat Jumat", "Umrah", "Haji", "Zakat"],
      jawaban: 2,
    ),
    Soal(
      soal: "Hukum melaksanakan salat lima waktu adalah",
      pilihan: ["Sunnah", "Wajib", "Mubah", "Makruh"],
      jawaban: 1,
    ),
    Soal(
      soal: "Surah pertama dalam Al-Qur’an adalah",
      pilihan: ["Al-Baqarah", "Al-Fatihah", "Al-Ikhlas", "An-Nas"],
      jawaban: 1,
    ),
    Soal(
      soal: "Sifat wajib bagi Rasul adalah",
      pilihan: ["Khianat", "Baladah", "Tabligh", "Kitman"],
      jawaban: 2,
    ),
    Soal(
      soal: "Hari kiamat kecil (sughra) ditandai dengan",
      pilihan: [
        "Hancurnya langit",
        "Gunung meletus",
        "Kematian seseorang",
        "Turunnya malaikat",
      ],
      jawaban: 2,
    ),
    Soal(
      soal: "Puasa yang hukumnya sunah adalah",
      pilihan: ["Puasa Ramadan", "Puasa Qadha", "Puasa Arafah", "Puasa Nazar"],
      jawaban: 2,
    ),
    Soal(
      soal: "Toleransi antar umat beragama disebut juga dengan",
      pilihan: [
        "Ukhuwah Islamiyah",
        "Ukhuwah Wathaniyah",
        "Ukhuwah Basyariyah",
        "Tasamuh",
      ],
      jawaban: 3,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 30),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 30;
    _animationController.reset();
    _animationController.forward();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
      } else {
        timer.cancel();
        if (!isAnswered) {
          checkAnswer(-1);
        }
      }
    });
  }

  void checkAnswer(int selectedIndex) {
    timer?.cancel();
    _animationController.stop();
    setState(() {
      isAnswered = true;
      selectedAnswer = selectedIndex;
      if (selectedIndex == soals[currentSoalIndex].jawaban) {
        score++;
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      nextSoal();
    });
  }

  void nextSoal() {
    if (currentSoalIndex < soals.length - 1) {
      setState(() {
        currentSoalIndex++;
        isAnswered = false;
        selectedAnswer = null;
        startTimer();
      });
    } else {
      showResults();
    }
  }

  void showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xff6c63ff).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      size: 60,
                      color: Color(0xff6c63ff),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kuis Selesai',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2c3e50),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Color(0xff6c63ff).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Skor Anda: $score/${soals.length}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6c63ff),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6c63ff),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        currentSoalIndex = 0;
                        score = 0;
                        isAnswered = false;
                        selectedAnswer = null;
                      });
                      startTimer();
                    },
                    child: Text(
                      'Ulangi Kuis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Color getOptionColor(int index) {
    if (isAnswered) return Colors.white;
    if (index == soals[currentSoalIndex].jawaban) {
      return Colors.green.shade400;
    }
    if (index == selectedAnswer && index != soals[currentSoalIndex].jawaban) {
      return Colors.redAccent;
    }

    return Colors.white;
  }

  @override
  void dispose() {
    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff6c63ff), Color(0xff3f3d9d)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.quiz, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      '${currentSoalIndex + 1} / ${soals.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Color(0xff6c63ff).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: CircularProgressIndicator(
                      value: _animation.value,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        timeLeft > 10 ? Colors.white : Color(0xffff6b6b),
                      ),
                      strokeWidth: 5,
                    ),
                  ),
                  Text(
                    timeLeft.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                physics: BouncingScrollPhysics(),
                child: Column(),
              ))
            ],
          ),
        ),

      ),
    );
  }
}
