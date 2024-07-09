import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/page/splash.dart';
import 'package:myapp/services/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BluetoothDataService bds;

  @override
  void initState() {
    super.initState();
    bds = BluetoothDataService();
    Get.put(bds);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluetooth Tomato Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: bds.blueEnabledStream,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return const SplashView();
          } else {
            return const Center(
              child: Icon(
                Icons.bluetooth_disabled,
                color: Colors.grey,
              ),
            );
          }
        },
      ),
    );
  }
}
