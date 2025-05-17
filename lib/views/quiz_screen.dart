import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/controllers/soal_controller.dart';
import 'package:flutter_application/views/body.dart';
import 'package:get/get.dart';

class QuizScreen extends StatefulWidget {
  final String kategory;
  const QuizScreen({super.key, required this.kategory});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  SoalController soalController = Get.put(SoalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 48, 42, 42),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: soalController.nextSoal,
            child: const Text('Lewati'),
          ),
        ],
      ),
      body: Body(),
    );
  }
}
