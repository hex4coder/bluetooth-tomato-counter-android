import 'package:flutter/material.dart';


class ConnectionWidget extends StatelessWidget {
  ConnectionWidget({this.isConnected = false, super.key});
  
  bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Icon( isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled , color: isConnected ? Colors.blue : Colors.grey,);
  }
}