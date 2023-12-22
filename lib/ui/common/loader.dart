import 'package:flutter/material.dart';
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
    );
  }
}
