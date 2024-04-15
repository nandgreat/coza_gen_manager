import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coza_gen_manager/components/base_screen.dart';
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
import 'manage_generators_controller.dart';

final pageList = [DECREE_YOUR_DAY_IMAGE, DECREE_YOUR_DAY_IMAGE];

class ManageGeneratorScreen extends StatefulWidget {
  ManageGeneratorScreen({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<ManageGeneratorScreen> createState() => _ManageGeneratorScreenState();
}

class _ManageGeneratorScreenState extends State<ManageGeneratorScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  ManageGeneratorsController manageKeysController =
      Get.put(ManageGeneratorsController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await manageKeysController.getGenerators(widget.type);
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
              title: widget.type == "pick"
                  ? "Turn On Generator"
                  : "Turn Off Generator",
              child: Container(
                child: Obx(() => manageKeysController.isLoading.value
                    ? const SizedBox(
                        height: 200.0,
                        child: Center(
                          child: SpinKitDualRing(
                            size: 50.0,
                            color: Colors.blue,
                          ),
                        ),
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
                                  const Text("Select Generator(s)"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomDropdown<String>.multiSelect(
                                    hintText: 'Select Generator',
                                    initialItems: manageKeysController.selectedGens.value,
                                    decoration: CustomDropdownDecoration(
                                        expandedBorder: Border.all(
                                            color: Colors.white30, width: 1.0)),
                                    items: manageKeysController.genList,
                                    onListChanged: (value) {
                                      manageKeysController.selectedGens.value =
                                          value;
                                      logItem('changing value to: $value');
                                    },
                                    listValidator: (value) => value.isEmpty
                                        ? "Select a generator"
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  const Text("Generator Load"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomDropdown<String>.multiSelect(
                                    hintText: 'Select Load',
                                    decoration: CustomDropdownDecoration(
                                        expandedBorder: Border.all(
                                            color: Colors.white30, width: 1.0)),
                                    items: manageKeysController.loads,
                                     initialItems: manageKeysController.selectedLoads.value,
                                    onListChanged: (value) {
                                      manageKeysController.selectedLoads.value = value;
                                      logItem('changing value to: $value');
                                    },
                                    listValidator: (value) => value.isEmpty
                                        ? "Generator Load is required"
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  CustomTextField(
                                    hintText: 'Select Purpose',
                                    label: "Purpose",
                                    ignoreCursor: true,
                                    suffixIcon: !manageKeysController
                                            .isPurposeLoading.value
                                        ? const Icon(
                                            CupertinoIcons.chevron_down)
                                        : SizedBox(
                                            width: 30.0,
                                            height: 30.0,
                                            child: SpinKitCircle(
                                              color: Colors.grey.shade700,
                                              size: 30.0,
                                            ),
                                          ),
                                    onFieldTap: handleLoadSecurityQuestions,
                                    controller:
                                        manageKeysController.purposeController,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  CustomTextField(
                                    hintText: 'Select Approval Admin',
                                    label: "Approved by",
                                    ignoreCursor: true,
                                    suffixIcon: !manageKeysController
                                            .isAdminLoading.value
                                        ? const Icon(
                                            CupertinoIcons.chevron_down)
                                        : SizedBox(
                                            width: 30.0,
                                            height: 30.0,
                                            child: SpinKitCircle(
                                              color: Colors.grey.shade700,
                                              size: 30.0,
                                            ),
                                          ),
                                    onFieldTap: handleLoadAdmins,
                                    controller:
                                        manageKeysController.adminController,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  CustomTextField(
                                    hintText: 'Enter Worker code',
                                    label: "Worker Code",
                                    textInputType: TextInputType.number,
                                    controller: manageKeysController
                                        .workerCodeController,
                                    obscureText: true,
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  CustomButton(
                                      label: "Turn On Generator",
                                      isLoading: manageKeysController
                                          .isSubmitting.value,
                                      onPressed: handleLogin)
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: 200,
                            width: deviceWidth(context),
                            child: const Center(
                                child: Text(
                              "All Generators are turned on at the moment",
                              style: TextStyle(fontSize: 18.0),
                            )),
                          ))),
              ))),
    );
  }

  void handleLogin() {
    hideKeyboard(context);
    if (_genFormKey.currentState!.validate()) {
      manageKeysController.turnOnGenerator();
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
