import 'package:flutter/material.dart';
import 'package:gpay_ui/constants.dart';

class UpiPinButton extends StatelessWidget {
  const UpiPinButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Color(0xffF1f1f1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            color: kUpiPinColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
