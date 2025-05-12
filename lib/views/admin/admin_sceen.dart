import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/soal_model.dart';
import 'package:flutter_application/controllers/soal_controller.dart';
import 'package:get/get.dart';

class AdminSceen extends StatelessWidget {
  final String kuiskategory;
  AdminSceen({super.key, required this.kuiskategory});
  final SoalController soalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambahkan Soal ke $kuiskategory')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: soalController.soalControllerText,
                decoration: const InputDecoration(labelText: 'Soal'),
              ),
              for (var i = 0; i < 4; i++)
                TextFormField(
                  controller: soalController.pilihanControllers[i],
                  decoration: InputDecoration(labelText: 'Pilihan ${i + 1}'),
                ),
              TextFormField(
                controller: soalController.jawabanBenarController,
                decoration: const InputDecoration(
                  labelText: 'Jawaban Benar(0-3)',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (soalController.soalControllerText.text.isEmpty) {
                    Get.snackbar('error', 'Harus Diisi Semua');
                  } else if (soalController
                      .pilihanControllers[0]
                      .text
                      .isEmpty) {
                    Get.snackbar('error', 'Harus Diisi Semua');
                  } else if (soalController
                      .pilihanControllers[1]
                      .text
                      .isEmpty) {
                    Get.snackbar('error', 'Harus Diisi Semua');
                  } else if (soalController
                      .pilihanControllers[2]
                      .text
                      .isEmpty) {
                    Get.snackbar('error', 'Harus Diisi Semua');
                  } else if (soalController
                      .pilihanControllers[3]
                      .text
                      .isEmpty) {
                    Get.snackbar('error', 'Harus Diisi Semua');
                  } else {
                    addSoals();
                  }
                },
                child: const Text('Tambahkan Soal'),
              ),
              // Simpan soal ke SharedPreferences
            ],
          ),
        ),
      ),
    );
  }

  void addSoals() async {
    final String soalText = soalController.soalControllerText.text;
    final List<String> pilihans =
        soalController.pilihanControllers
            .map((controller) => controller.text)
            .toList();

    final int jawaban =
        int.tryParse(soalController.jawabanBenarController.text) ?? 1;

    final Soal newSoal = Soal(
      kategory: kuiskategory,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      soal: soalText,
      pilihan: pilihans,
      jawaban: jawaban,
    );

    await soalController.saveSoalToSharedPreferences(newSoal);

    Get.snackbar('Berhasil', 'Soal Ditambahkan');
    soalController.soalControllerText.clear();
    soalController.pilihanControllers.forEach((element) {
      element.clear();
    });
  }
}
