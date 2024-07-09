import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/services/data.dart';
import 'package:myapp/widget/nodata.dart';

class BlueSearchList extends StatefulWidget {
  const BlueSearchList({super.key});

  @override
  State<BlueSearchList> createState() => _BlueSearchListState();
}

class _BlueSearchListState extends State<BlueSearchList> {
  BluetoothDataService bds = Get.find();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () async {
      bool ada = await bds.scanningSystemDevices();
      if (!ada) {
        Get.snackbar("Scanning2", "Scanning.....");
        await bds.scanningDevices();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Bluetooth Devices'),
      children: <Widget>[
        const Divider(),
        Obx(() => bds.isScanning
            ? const CircularProgressIndicator()
            : (bds.devices.isEmpty
                ? const NoDataWidget(text: "Tidak ada bluetooth")
                : Column(
                    children: bds.devices.map((dev) {
                      return ListTile(
                        leading: const Icon(Icons.bluetooth),
                        title: Text(dev.name),
                        subtitle: Text(dev.address),
                        onTap: () async {
                          await bds.connectToDevice(dev);
                          Get.back();
                        },
                      );
                    }).toList(),
                  ))),
      ],
    );
  }
}
