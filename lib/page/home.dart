// Suggested code may be subject to a license. Learn more: ~LicenseLog:3858707840.
import 'package:flutter/material.dart';
import 'package:myapp/widget/connection.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                accountName: Text('Tomato Counter'),
                accountEmail: Text('By Muhajirin - Teknik Informatika'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
        ),
        body: // Add the following code to the build method of the Home class:

            SizedBox.fromSize(
              size: MediaQuery.of(context).size,
              child: Column(
                
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          Card(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConnectionWidget(),
                          ),),
                          const SizedBox(height: 20),


              // Display the number of rotten tomatoes
              Text('Tomat Busuk: ${0}'),
              
              // Display the number of good tomatoes
              Text('Tomat Bagus: ${0}'),
              
              // Display the number of half-ripe tomatoes
              Text('Tomat Setengah Matang: ${0}'),
                        ],
                      ),
            ));
  }
}
