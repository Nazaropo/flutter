import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/controllers/soal_controller.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    SoalController soalController = Get.find();
    return Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset('assets/bg.svg', fit: BoxFit.fitWidth),
        SafeArea(
          child: Column(
            children: [
              Obx(
                () => Text.rich(
                  TextSpan(
                    text: 'Soal ${soalController.soalNomor.value}',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(color: kScondaryColor),
                    children: [
                      TextSpan(
                        text: '/${soalController.soals.length}',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: kScondaryColor),//36 : 05
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
