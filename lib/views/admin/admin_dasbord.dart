import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/soal_controller.dart';
import 'package:flutter_application/views/admin/admin_sceen.dart';
import 'package:get/get.dart';

class AdminDAsbord extends StatefulWidget {
  const AdminDAsbord({super.key});

  @override
  State<AdminDAsbord> createState() => _AdminDAsbordState();
}

class _AdminDAsbordState extends State<AdminDAsbord> {
  @override
  void initState() {
    super.initState();
    soalController.loadSoalKategoryFromSharedPrefrences();
  }

  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  final SoalController soalController = Get.put(SoalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dasbord')),
      body: Obx(() {
        return ListView.builder(
          itemCount: soalController.savedKategoris.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Get.to(
                    AdminSceen(
                      kuiskategory: soalController.savedKategoris[index],
                    ),
                  );
                },
                leading: const Icon(Icons.question_answer),
                title: Text(soalController.savedKategoris[index]),
                subtitle: Text(soalController.savedDeskripsi[index]),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogBox,
        child: const Icon(Icons.add),
      ),
    );
  }

  _showDialogBox() {
    soalController.kategoryJudulController.clear();
    soalController.kategoryDeskripsiController.clear();

    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      title: "Tambah Kuis",
      content: Column(
        children: [
          TextFormField(
            controller: soalController.kategoryJudulController,
            decoration: const InputDecoration(hintText: 'Judul Kuis'),
          ),
          TextField(
            controller: soalController.kategoryDeskripsiController,
            decoration: const InputDecoration(hintText: 'Deskripsi Kuis'),
          ),
        ],
      ),
      textConfirm: 'Simpan',
      textCancel: 'Batal',
      onConfirm: () {
        soalController.savedSoalKategoryToSharedPrefrences();
        Get.back();
      },
    );
  }
}
