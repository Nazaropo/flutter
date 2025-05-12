import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/soal_model.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

class SoalController extends GetxController {
  final List<Soal> _soals = [];
  List<Soal> get soals => _soals;
  final TextEditingController soalController = TextEditingController();
  final List<TextEditingController> pilihanControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final TextEditingController jawabanController = TextEditingController();
  final TextEditingController kuiskategory = TextEditingController();

  Future<void> saveSoalToSharedPreferences(Soal soal) async {
    final prefs = await SharedPreferences.getInstance();
    final soals = await prefs.getStringList('soals') ?? [];

    soals.add(jsonEncode(soal.toJson()));
    await prefs.setStringList('soals', soals);
  }

  //admin dasboard
  final String _kategoryKey = 'kategory_judul';
  final String _deskripsiKey = 'deskripsi';
  TextEditingController kategoryJudulController = TextEditingController();

  TextEditingController kategoryDeskripsiController = TextEditingController();

  RxList<String> savedKategoris = <String>[].obs;
  RxList<String> savedDeskripsi = <String>[].obs;

  TextEditingController get soalControllerText => soalController;
  TextEditingController get jawabanBenarController => jawabanController;

  void savedSoalKategoryToSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();

    // Debug print untuk memastikan input tidak kosong
    print("Judul: ${kategoryJudulController.text}");
    print("Deskripsi: ${kategoryDeskripsiController.text}");

    savedKategoris.add(kategoryJudulController.text);
    savedDeskripsi.add(kategoryDeskripsiController.text);

    await prefs.setStringList(_kategoryKey, savedKategoris);
    await prefs.setStringList(_deskripsiKey, savedDeskripsi);

    kategoryJudulController.clear();
    kategoryDeskripsiController.clear();

    Get.snackbar('Tersimpan', 'Kategory Berhasil Disimpan');

    update(); // jika masih pakai GetBuilder
  }

  void loadSoalKategoryFromSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();
    final kategoris = prefs.getStringList(_kategoryKey) ?? [];
    final deskripsis = prefs.getStringList(_deskripsiKey) ?? [];

    savedKategoris.assignAll(kategoris);
    savedDeskripsi.assignAll(deskripsis);
    update();
  }
}
