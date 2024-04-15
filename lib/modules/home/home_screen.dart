import 'package:coza_gen_manager/components/base_screen.dart';
import 'package:coza_gen_manager/modules/home/home_controller.dart';
import 'package:coza_gen_manager/modules/manage_generators/manage_generators_screen.dart';
import 'package:coza_gen_manager/modules/refuel_generator/refuel_generators_screen.dart';
import 'package:coza_gen_manager/modules/turn_off_generators/turnoff_generators_screen.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../models/login/login_response.dart';
import '../../res/color_palette.dart';
import '../../res/images.dart';

final pageList = [DECREE_YOUR_DAY_IMAGE, DECREE_YOUR_DAY_IMAGE];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  HomeController homeController = Get.put(HomeController());

  Data user = Data();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeController.getUser();
      await homeController.getDieselBalance();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BaseScreen(
          useToolBar: false,
          child: Obx(
            () => Column(
              children: [
                const SizedBox(
                  width: 30.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: primaryColor),
                        image: const DecorationImage(
                            image: AssetImage(DEMO_USER_IMAGE)),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          homeController.userData.value!.user!.firstName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                              height: 1,
                              color: primaryColor),
                        ),
                        const Text("Generator Manager"),
                      ],
                    ))
                  ],
                ),
                RefreshIndicator(
                  onRefresh: () async =>
                      await homeController.getDieselBalance(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          "Diesel Level",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          formatMoney(homeController
                              .userData.value!.dieselDetails!.dieselLevel!),
                          style: TextStyle(
                              fontSize: 46.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            homeCard(title:"Turn On", color: Colors.green.shade300, onTap: () => Get.to(ManageGeneratorScreen(type: "pick"))),
                            const SizedBox(
                              width: 20,
                            ),
                            homeCard(title: "Turn Off", onTap: () => Get.to(TurnoffGeneratorScreen(type: "drop"))),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            homeCard(title:"Refuel", color: Colors.blue.shade300, onTap: () => Get.to(const RefuelGeneratorScreen())),
                            const SizedBox(
                              width: 20,
                            ),
                            homeCard(title: "Refuel\nHistory", color: Colors.orange.shade300, onTap: () {}),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            homeCard(title:"Gen\nSessions", onTap: () => Get.to(ManageGeneratorScreen(type: "pick"))),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        InkWell(
                            onTap: () => homeController.logout(),
                            child: Text(
                              "Logout",
                              style: TextStyle(fontSize: 18.0),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded homeCard({required String title, required VoidCallback onTap, Color color = Colors.red}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
