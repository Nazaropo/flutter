import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/soal_model.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application/views/nilai_page.dart';

import 'package:get/get.dart';

class SoalController extends GetxController {
  //User
  late PageController _pageController;
  PageController get pageController => _pageController;
  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  int _selectedAns = 0;
  int get selectedAns => _selectedAns;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  final RxInt _soalNomor = 1.obs;
  RxInt get soalNomor => _soalNomor;

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

  void loadSoalFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final soalJson = prefs.getStringList('soals') ?? [];

    _soals.clear();
    _soals.addAll(
      soalJson.map((json) => Soal.fromJson(jsonDecode(json))).toList(),
    );
    update();
  }

  List<Soal> getSoalsByKategory(String kategory) {
    return _soals.where((soal) => soal.kategory == kategory).toList();
  }

  void checkAns(Soal soal, int selectedINdex) {
    _isAnswered = true;
    _correctAns = soal.jawaban;
    _selectedAns = selectedINdex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    nextSoal();
  }

  void nextSoal() async {
    if (_soalNomor.value != _soals.length) {
      _isAnswered = false;

      _pageController.nextPage(
        duration: const Duration(microseconds: 250),
        curve: Curves.ease,
      );
    } else {
      Get.to(const NilaiPage());
    }
  }

  @override
  void onInit() {
    loadSoalKategoryFromSharedPrefrences();
    loadSoalFromSharedPreferences();
    _pageController = PageController();
    super.onInit();
  }
}
