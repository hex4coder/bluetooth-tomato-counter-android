// Suggested code may be subject to a license. Learn more: ~LicenseLog:3858707840.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/services/data.dart';
import 'package:myapp/widget/blue-search-list.dart';
import 'package:myapp/widget/connection.dart';
import 'package:myapp/widget/nodata.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // global vars
  BluetoothDataService bds = Get.find();

  // ============================= RENDER UI ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // tombol koneksi bluetooth
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(const BlueSearchList());
          },
          child: const Icon(
            Icons.bluetooth_searching,
          ),
        ),

        // =================================================================== screen view ========================================= //
        // screen body
        body: SizedBox.fromSize(
          size: MediaQuery.of(context).size,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // user info and bluetooth connection
                _buildUserInfo(),

                // spacer
                const SizedBox(height: 20),

                // dinamis data

                // no data widget
                const NoDataWidget(),
              ],
            ),
          ),
        ));
  }

  // ============================================ widgets area ========================================= ///
  Widget _buildBluetoothStatus() {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Status Bluetooth",
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(() => ConnectionWidget(
                  isConnected: bds.connected,
                )),
            const SizedBox(
              height: 5,
            ),
            Obx(() => Text(
                  bds.connected ? "Terhubung" : "Terputus",
                  style: const TextStyle(fontSize: 14),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Stack(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          accountName: Text('Tomato Counter'),
          accountEmail: Text('By Muhajirin - Teknik Informatika'),
        ),
        Positioned(
          right: 16,
          top: 38,
          child: _buildBluetoothStatus(),
        ),
      ],
    );
  }
}
