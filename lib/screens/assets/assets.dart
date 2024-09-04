import 'package:flutter/material.dart';

class Assets {
  Widget inputfield(
      {required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: '$hint'),
    );
  }

  Widget ThemeButton(double height, double width, String text,
      VoidCallback? providerfunction) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Removes rounded corners
            ),
          ),
          onPressed: providerfunction,
          child: Text(
            "$text",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
