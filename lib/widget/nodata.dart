import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(
                children: [
                  Image.asset("assets/images/no-data.png"),
                  const Text("Tidak ada data"),
                ],
              );
  }
}