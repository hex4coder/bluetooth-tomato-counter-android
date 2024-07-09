import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({this.text = "Tidak ada data", super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/no-data.png"),
        Text(text),
      ],
    );
  }
}
