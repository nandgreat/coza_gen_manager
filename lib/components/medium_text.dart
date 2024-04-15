import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  final String text;
  final bool? isBold;
  final double? size;
  final Color? color;
  final String? fontFamily;
  final VoidCallback? onPress;
  final TextAlign? textAlign;

  const MediumText(
      {Key? key,
      this.textAlign = TextAlign.start,
      this.onPress,
      this.color = Colors.grey,
      this.isBold = false,
      required this.text,
      this.size, this.fontFamily = "Poppins"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPress,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
              color: color!,
              fontFamily: fontFamily ?? "Poppins",
              fontSize: size ?? 18.0,
              fontWeight: isBold! ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
