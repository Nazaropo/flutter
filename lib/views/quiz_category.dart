import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/soal_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuizKategorySceen extends StatelessWidget {
  QuizKategorySceen({super.key});

  final SoalController _soalController = Get.find<SoalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset('assets/bg.svg', fit: BoxFit.cover),
          ),
          Obx(
            () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _soalController.savedKategoris.length,
              itemBuilder: (context, index) {
                return Card(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.question_answer),
                        Text(_soalController.savedKategoris[index]),
                        Text(_soalController.savedDeskripsi[index]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
