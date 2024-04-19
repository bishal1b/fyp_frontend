import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final void Function()? onPressed;
  const MyButton(
      {super.key, required this.text, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (!isLoading) {
          onPressed?.call();
        }
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFF2E9E95),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
