import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.colour,
    required this.label,
    required this.onPress,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.padvertical,
    required this.padhorizontal,
    required this.borderWidth,
    required this.fill,
    required this.style,
  });

  final String label;
  final Color colour;
  final VoidCallback onPress;
  final double width;
  final double height;
  final double borderRadius;
  final double padvertical;
  final double padhorizontal;
  final double borderWidth;
  final Color fill;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        // The OutlinedButton
        SizedBox(
          width: width,
          height: height,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              side: BorderSide(color: colour, width: borderWidth),
              backgroundColor: Colors.transparent,
            ),
            onPressed: onPress,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: padvertical,
                horizontal: padhorizontal,
              ),
              child: Text(
                label,
                style: style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
