import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final double height;
  final Function onpressed;
  final double radius;

  const ButtonWidget(
      {super.key,
      required this.buttonText,
      required this.height,
      required this.width,
      required this.onpressed,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ),
      onPressed: () {
        onpressed();
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueAccent],
          ),
        ),
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
