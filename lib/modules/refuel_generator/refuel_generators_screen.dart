import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coza_gen_manager/components/base_screen.dart';
import 'package:coza_gen_manager/modules/refuel_generator/refuel_generators_controller.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:get/get.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_input.dart';
import '../../components/image_upload_widget.dart';
import '../../components/medium_text.dart';
import '../../res/images.dart';

final pageList = [DECREE_YOUR_DAY_IMAGE, DECREE_YOUR_DAY_IMAGE];

class RefuelGeneratorScreen extends StatefulWidget {
  const RefuelGeneratorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RefuelGeneratorScreen> createState() => _RefuelGeneratorScreenState();
}

class _RefuelGeneratorScreenState extends State<RefuelGeneratorScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  RefuelGeneratorsController manageKeysController =
      Get.put(RefuelGeneratorsController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await manageKeysController.getGenerators("off");
    });
    super.initState();
  }


  handleImageSelect(String type) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () {
                    Get.back();
                    manageKeysController.uploadImage(
                        imageSource: ImageSource.camera, type: type);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () {
                    Get.back();
                    manageKeysController.uploadImage(
                        imageSource: ImageSource.gallery, type: type);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _genFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BaseScreen(
              useToolBar: true,
              title: "Refuel Generator",
              child: Obx(() => SizedBox(
                    child: Form(
                      key: _genFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            hintText: 'Enter Quantity',
                            label: "Diesel Quantity",
                            textInputType: TextInputType.number,
                            controller:
                                manageKeysController.dieselLevelController,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: ImageUploadWidget(
                              label: "Diesel Level Before Image",
                              onPressed: () => handleImageSelect("gen_before"),
                              imageUrl: manageKeysController
                                  .genLevelBeforeImage.value,
                              isLoading: manageKeysController
                                  .genLevelBeforeImageLoading.value,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: ImageUploadWidget(
                              label: "Diesel Level After Image",
                              onPressed: () => handleImageSelect("gen_after"),
                              imageUrl: manageKeysController
                                  .genLevelAfterImage.value,
                              isLoading: manageKeysController
                                  .genLevelAfterImageLoading.value,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: ImageUploadWidget(
                              label: "Invoice Image",
                              onPressed: () => handleImageSelect("invoice"),
                              imageUrl: manageKeysController
                                  .invoiceImage.value,
                              isLoading: manageKeysController
                                  .invoiceImageLoading.value,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: ImageUploadWidget(
                              label: "Waybill Image",
                              onPressed: () => handleImageSelect("waybill"),
                              imageUrl: manageKeysController
                                  .wayBillImage.value,
                              isLoading: manageKeysController
                                  .wayBillImageLoading.value,
                            ),
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
                            height: 20.0,
                          ),
                          CustomTextField(
                            hintText: 'Enter Worker Code',
                            label: "Confirmation Worker code",
                            textInputType: TextInputType.number,
                            controller:
                            manageKeysController.confirmationWorkerCodeController,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          CustomButton(
                              label: "Refuel Generator",
                              isLoading:
                                  manageKeysController.isLoading.value,
                              onPressed: handleLogin)
                        ],
                      ),
                    ),
                  )))),
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
