import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// data service
class BluetoothDataService extends GetxService {
  // obs data
  final _connected = false.obs;
  final _connecting = false.obs;
  final _bluetoothSearching = false.obs;
  final _bluetoothEnabled = false.obs;
  final RxList<BluetoothDevice> _devices = RxList<BluetoothDevice>.empty();
  late Logger _logger;

  String _strData = "";
  bool _constructingData = false;

  @override
  void onInit() {
    super.onInit();
    _logger = Logger();
    setupBluetooth();
  }

  // ============================================== FUNGSI ==========================================

  // fungsi untuk konek ke bluetooth device tertentu
  Future<bool> connectToDevice(BluetoothDevice device) async {
    // listen for disconnection
    _connecting.value = true;
    try {
      _logger.i("Connecting to device ${device.address}");
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(device.address);

      _connected.value = connection.isConnected;
      if (connected) {
        _logger.i('Connected to the device');
        _logger.i("Try to listening to data");

        connection.input?.listen((Uint8List data) {
          String s = utf8.decode(data);

          if (_constructingData) {
            _strData += s;
          }

          if (s.contains("#")) {
            _constructingData = false;
            _strData = _strData.removeAllWhitespace;

            if (_strData.contains("*") && _strData.contains("#")) {
              // data complete
              _logger.w("Data completed");
              List<String> listData = _strData.split("#");
              if (listData.isNotEmpty) {
                String dataRaw = listData[0]
                    .replaceAll("*", "")
                    .replaceAll("#", "")
                    .removeAllWhitespace;

                List<String> dataRaw2 = dataRaw.split("~");
                int bgs = int.tryParse(dataRaw2[0]) ?? 0;
                int smtg = int.tryParse(dataRaw2[1]) ?? 0;
                int bsk = int.tryParse(dataRaw2[2]) ?? 0;

                _matang.value = bgs;
                _setengahMatang.value = smtg;
                _busuk.value = bsk;
              }
            }
          }

          if (s.contains("*")) {
            _strData = s;
            _constructingData = true;
          }
        }).onDone(() {
          _connected.value = false;
          _logger.w('Disconnected by remote request');
        });
      } else {
        _logger.w("Not Connected to ${device.address}");
      }
    } catch (exception) {
      _connected.value = false;
      _logger.f('Cannot connect, exception occured ${exception.toString()}');
    }
    _connecting.value = false;

    return _connected.value;
  }

  // scanning for system devs
  Future<bool> scanningSystemDevices() async {
    List<BluetoothDevice> devs =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    _devices.assignAll(devs);

    return _devices.isNotEmpty;
  }

  // fungsi untuk mencari bluetooth (scanning)
  Future<void> scanningDevices() async {
    var subs =
        FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
      _devices.add(result.device);
    });

    await Future.delayed(const Duration(seconds: 5));
    await FlutterBluetoothSerial.instance.cancelDiscovery();
    await subs.cancel();
  }

  // fungsi inisialisasi bluetooth
  Future<void> setupBluetooth() async {
    bool? enabled = await FlutterBluetoothSerial.instance.isEnabled;
    _bluetoothEnabled.value = enabled == true;
    if (!bluetoothEnabled) {
      Get.snackbar("OFF", "Bluetooth tidak aktif.");
    }

    if (enabled == true) {
      return;
    }

    Get.snackbar("Permission", "Izinkan aplikasi ini untuk akses bluetooth!");
  }

  // ============================================ PROPERTI AREA ============================
  // setter and getter for bluetooth searching

  Stream<bool> get blueEnabledStream => _bluetoothEnabled.stream;

  bool get isConnecting => _connecting.value;
  bool get isScanning => _bluetoothSearching.value;

  List<BluetoothDevice> get devices => _devices;
  set devices(List<BluetoothDevice> newList) => _devices.assignAll(newList);

  bool get bluetoothSearching => _bluetoothSearching.value;
  set bluetoothSearching(bool value) => _bluetoothSearching.value = value;

  // setter and getter for bluetooth enabled
  bool get bluetoothEnabled => _bluetoothEnabled.value;
  set bluetoothEnabled(bool value) => _bluetoothEnabled.value = value;

  // properti getter and setter
  bool get connected => _connected.value;
  set connected(bool value) => _connected.value = value;

  bool get isDataEmpty =>
      _busuk.value == 0 && _setengahMatang.value == 0 && _matang.value == 0;

  // data for tomato
  final _busuk = 0.obs;
  final _matang = 0.obs;
  final _setengahMatang = 0.obs;

  // setter and getter for tomato data
  int get busuk => _busuk.value;
  set busuk(value) => _busuk.value = value;

  int get matang => _matang.value;
  set matang(value) => _matang.value = value;

  int get setengahMatang => _setengahMatang.value;
  set setengahMatang(value) => _setengahMatang.value = value;
}
