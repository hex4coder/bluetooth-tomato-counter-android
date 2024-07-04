import 'package:get/get.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// data service
class BluetoothDataService extends GetxService {


  // obs data
  final _connected = false.obs;
  final _bluetoothSearching = false.obs;
  final _bluetoothEnabled = false.obs;
  final _bluetoothName = ''.obs;
  final _bluetoothAddress = ''.obs;
  late Rx<BluetoothConnection?> _blueConn; // TODO: Membuat koneksi bluetooth dengan Arduino Mega
  // TODO: Menerima data dari Arduino dengan format *data*12~23~32# bagus, setengah matang, busuk

























  // ============================================ PROPERTI AREA ============================
  BluetoothConnection? get blueConn => _blueConn.value;
  set blueConn(BluetoothConnection? value) => _blueConn.value = value;
  // setter and getter for bluetooth searching
  bool get bluetoothSearching => _bluetoothSearching.value;
  set bluetoothSearching(bool value) => _bluetoothSearching.value = value;

  // setter and getter for bluetooth enabled
  bool get bluetoothEnabled => _bluetoothEnabled.value;
  set bluetoothEnabled(bool value) => _bluetoothEnabled.value = value;

  // setter and getter for bluetooth name
  String get bluetoothName => _bluetoothName.value;
  set bluetoothName(String value) => _bluetoothName.value = value;

  // setter and getter for bluetooth address
  String get bluetoothAddress => _bluetoothAddress.value;
  set bluetoothAddress(String value) => _bluetoothAddress.value = value;

  // properti getter and setter
  bool get connected => _connected.value;
  set connected(bool value) => _connected.value = value;

  // data for tomato
  final _busuk = 0.obs;
  final _matang = 0.obs;
  final _setengahMatang = 0.obs;

  // setter and getter for tomato data
  get busuk => _busuk.value;
  set busuk(value) => _busuk.value = value;

  get matang => _matang.value;
  set matang(value) => _matang.value = value;

  get setengahMatang => _setengahMatang.value;
  set setengahMatang(value) => _setengahMatang.value = value;
}
