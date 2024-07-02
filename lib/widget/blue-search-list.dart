import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlueSearchList extends StatelessWidget {
  const BlueSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Bluetooth Devices'),
      children: <Widget>[
        const Divider(),
        ListTile(
          leading: Icon(Icons.bluetooth),
          title: Text('Device Name'),
          subtitle: Text('Device Address'),
          onTap: () {
            Get.back();
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.bluetooth),
          title: Text('Device Name'),
          subtitle: Text('Device Address'),
          onTap: () {
            Get.back();
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.bluetooth),
          title: Text('Device Name'),
          subtitle: Text('Device Address'),
          onTap: () {
            Get.back();
          },
        ),
      ],
    );
  }
}