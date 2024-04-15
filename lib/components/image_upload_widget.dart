import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../animation_components/slidein_up_anim.dart';
import '../res/color_palette.dart';
import '../res/images.dart';

class ImageUploadWidget extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final Color? labelColor;
  final Widget? icon;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const ImageUploadWidget(
      {Key? key,
      this.imageUrl,
      this.labelColor,
      this.icon,
      required this.isLoading,
      required this.onPressed,
      this.backgroundColor,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style:  TextStyle(
            fontWeight: FontWeight.w500,
            color: primaryColor,
            fontSize: 17.0,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          child: SlideInAnimationWidget(
              child: InkWell(
            onTap: isLoading ? () {} : onPressed,
            child: isLoading
                ? Container(
                    width: 100.0,
                    height: 100.0,
                    child:  SpinKitCircle(
                      color: primaryColor,
                      size: 30.0,
                    ),
                  )
                : Container(
                    child: imageUrl == ""
                        ? Image.asset(
                            DEFAULT_IMAGE_FOR_IMAGE_UPLOADE,
                            width: 310,
                          )
                        : Image(image: NetworkImage(
                            imageUrl!,
                          ), height: 310),
                  ),
          )),
        ),
        const SizedBox(
          height: 25.0,
        ),
      ],
    );
  }
}
