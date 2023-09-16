import 'package:flutter/material.dart';
import 'package:gpay_ui/constants.dart';

class UpiBackButton extends StatelessWidget {
  const UpiBackButton({
    super.key,
    required this.onTap,
  });
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
        child: const Icon(
          Icons.backspace,
          color: kUpiPinColor,
        ),
      ),
    );
  }
}

class UpiCheckButton extends StatelessWidget {
  const UpiCheckButton({
    super.key,
    required this.onTap,
  });
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
        child: const Icon(
          Icons.check_circle,
          size: 30,
          color: kUpiPinColor,
        ),
      ),
    );
  }
}
