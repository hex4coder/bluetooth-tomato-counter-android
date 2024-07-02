// Suggested code may be subject to a license. Learn more: ~LicenseLog:3858707840.
import 'package:flutter/material.dart';
import 'package:myapp/widget/connection.dart';
import 'package:myapp/widget/nodata.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ConnectionWidget(),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Terputus",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Stack(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          accountName: Text('Tomato Counter'),
          accountEmail: Text('By Muhajirin - Teknik Informatika'),
        ),
        Positioned(
          child: _buildBluetoothStatus(),
          right: 16,
          top: 16,
        ),
      ],
    );
  }
}
