import 'package:coza_gen_manager/res/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? leftOnPress;
  final bool? showBackBtn;
  final VoidCallback? rightOnPress;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.leftIcon,
      this.rightIcon,
      this.leftOnPress,
      this.showBackBtn = true,
      this.rightOnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showBackBtn != null
                ? showBackBtn!
                    ? InkWell(
                        onTap: leftOnPress ?? () => Get.back(),
                        child: leftIcon ?? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      )
                    : const SizedBox( width: 25, height: 25,)
                : InkWell(
                    onTap: leftOnPress ?? () => Get.back(),
                    child: leftIcon ?? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(CupertinoIcons.back),
                      ),
                    ),
                  ),
            Text(
              title ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 20.0),
            ),
            rightIcon != null
                ? rightIcon!
                : const SizedBox( width: 25, height: 25,),
          ],
        ),
      ),
    );
  }
}
