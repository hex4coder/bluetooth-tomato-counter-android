import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/services/data.dart';

class DataWidget extends StatefulWidget {
  const DataWidget({super.key});

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  // global vars for data service
  BluetoothDataService bds = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => _buildText(bds.matang, "Bagus / Matang")),
        Obx(() => _buildText(bds.setengahMatang, "Setengah Matang")),
        Obx(() => _buildText(bds.busuk, "Busuk")),
      ],
    );
  }
}

Widget _buildText(int data, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        data.toString(),
        style: const TextStyle(
            color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w700),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        label,
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      )
    ],
  );
}
