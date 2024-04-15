import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coza_gen_manager/components/base_screen.dart';
import 'package:coza_gen_manager/components/no_result_widget.dart';
import 'package:coza_gen_manager/models/generators/generator_list_response.dart';
import 'package:coza_gen_manager/modules/turn_off_generators/turnoff_generators_controller.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:get/get.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_input.dart';
import '../../components/medium_text.dart';
import '../../res/images.dart';

final pageList = [DECREE_YOUR_DAY_IMAGE, DECREE_YOUR_DAY_IMAGE];

class TurnoffGeneratorScreen extends StatefulWidget {
  TurnoffGeneratorScreen({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<TurnoffGeneratorScreen> createState() => _TurnoffGeneratorScreenState();
}

class _TurnoffGeneratorScreenState extends State<TurnoffGeneratorScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  TurnoffGeneratorsController manageKeysController =
      Get.put(TurnoffGeneratorsController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await manageKeysController.getGenerators("off");
    });
    super.initState();
  }

  handleLoadSecurityQuestions() async {
    await manageKeysController.getPurposes();

    if (manageKeysController.purposes.isNotEmpty) {
      showBarModalBottomSheet(
          expand: false,
          context: context,
          bounce: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Obx(() {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      const Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: MediumText(
                                  isBold: true, text: "Select Purpose")),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 20.0),
                        child: Container(
                          height: deviceHeight(context) - 100,
                          child: ListView.separated(
                            itemCount:
                                manageKeysController.purposes.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(manageKeysController
                                    .purposes.value[index].generatorPurpose!),
                                onTap: () {
                                  manageKeysController.purposes.value[index];
                                  manageKeysController.purposeController.text =
                                      manageKeysController.purposes.value[index]
                                          .generatorPurpose!;

                                  manageKeysController.purposeId.value =
                                      manageKeysController
                                          .purposes.value[index].id!
                                          .toString();
                                  Get.back();
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          });
    }
  }

  handleLoadAdmins() async {
    await manageKeysController.getAdmins();

    if (manageKeysController.admins.isNotEmpty) {
      showBarModalBottomSheet(
          expand: false,
          context: context,
          bounce: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Obx(() {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      const Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: MediumText(
                                  isBold: true, text: "Select Approval Admin")),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 20.0),
                        child: Container(
                          height: deviceHeight(context) - 100,
                          child: ListView.separated(
                            itemCount: manageKeysController.admins.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(manageKeysController
                                    .admins.value[index].approvalAdmin!),
                                onTap: () {
                                  manageKeysController.admins.value[index];
                                  manageKeysController.adminController.text =
                                      manageKeysController
                                          .admins.value[index].approvalAdmin!;

                                  manageKeysController.adminId.value =
                                      manageKeysController
                                          .admins.value[index].id!
                                          .toString();
                                  Get.back();
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          });
    }
  }

  final _genFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BaseScreen(
              useToolBar: true,
              title: "Turn Off Generator",
              child: Obx(() => manageKeysController.isLoading.value
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200.0,
                          child: Center(
                            child: SpinKitDualRing(
                              size: 50.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    )
                  : (manageKeysController.keys.isNotEmpty
                      ? SizedBox(
                          child: Form(
                            key: _genFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("Select Generator"),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomDropdown<String>(
                                  hintText: 'Select Active Generator',
                                  items: manageKeysController.genList,
                                  initialItem: manageKeysController
                                      .selectedActiveGen.value.isEmpty ? null :  manageKeysController
                                      .selectedActiveGen.value,
                                  onChanged: (value) {
                                    manageKeysController
                                        .selectedActiveGen.value = value;
                                    logItem('changing value to: $value');
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                CustomTextField(
                                  hintText: 'Enter Diesel Level (Optional)',
                                  label: "Diesel Level",
                                  textInputType: TextInputType.number,
                                  functionValidate: (value) => null,
                                  controller: manageKeysController
                                      .dieselLevelController,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                CustomTextField(
                                  hintText: 'Enter Worker code',
                                  label: "Worker Code",
                                  textInputType: TextInputType.number,
                                  controller:
                                      manageKeysController.workerCodeController,
                                  obscureText: true,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                CustomButton(
                                    label: "Turn Off Generator",
                                    isLoading:
                                        manageKeysController.isSubmitting.value,
                                    onPressed: handleLogin)
                              ],
                            ),
                          ),
                        )
                      : Center(child: const NoResultWidget(title: "No Active Generators found")))))),
    );
  }

  void handleLogin() {
    hideKeyboard(context);
    if (_genFormKey.currentState!.validate()) {
      manageKeysController.turnOffGenerator();
    }
  }
}

Widget homeSlider(BuildContext context, int index) {
  return Container(
    width: 130,
    height: 130,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: AssetImage(pageList[index]), fit: BoxFit.contain)),
    margin: const EdgeInsets.only(right: 10),
  );
}

class Animal {
  late int id;
  late String name;

  Animal({
    required this.id,
    required this.name,
  });
}
