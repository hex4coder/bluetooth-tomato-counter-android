import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// data service
class BluetoothDataService extends GetxService {
  // obs data
  final _connected = false.obs;
  final _bluetoothSearching = false.obs;
  final _bluetoothEnabled = false.obs;
  final _bluetoothName = ''.obs;
  final _bluetoothAddress = ''.obs;
  BluetoothDevice? _connectedDevice;
  final RxList<BluetoothDevice> _devices = RxList<BluetoothDevice>.empty();

  late Logger _logger;
  late AllBluetooth _allBluetooth;

  @override
  void onInit() {
    super.onInit();
    _logger = Logger();
    _allBluetooth = AllBluetooth();
    setupBluetooth();
  }

  // ============================================== FUNGSI ==========================================

  // fungsi untuk konek ke bluetooth device tertentu
  Future<void> connectToDevice(BluetoothDevice device) async {
    // listen for disconnection
    _connected.value = false;
    _allBluetooth.listenForConnection.listen((ConnectionResult res) {
      _connectedDevice = res.device;
      _connected.value = res.state;

      if (res.state) {
        Get.snackbar("Connected", "Terhubung ke ${res.device?.name}");
      } else {
        Get.snackbar("Disconnected", "Koneksi terputus.");
      }
    });
    await _allBluetooth.connectToDevice(device.address);
  }

  // scanning for system devs
  Future<bool> scanningSystemDevices() async {
    List<BluetoothDevice> devs = await _allBluetooth.getBondedDevices();
    _devices.assignAll(devs);

    return _devices.isNotEmpty;
  }

  // fungsi untuk mencari bluetooth (scanning)
  Future<void> scanningDevices() async {
    // listen to scan results
    // Note: `onScanResults` only returns live scan results, i.e. during scanning. Use
    //  `scanResults` if you want live scan results *or* the results from a previous scan.
    var subscription = _allBluetooth.discoverDevices.listen(
      (device) {
        _logger.i("Ada device baru ${device.address} [${device.name}]\n");
        _devices.add(device);
      },
      onError: (e) {
        _bluetoothSearching.value = false;
        Get.snackbar("Error Scanning Devices", e.toString());
        _devices.assignAll([]);
      },
    );

    _bluetoothSearching.value = true;
    await _allBluetooth.startDiscovery();
    await Future.delayed(const Duration(seconds: 5));
    await _allBluetooth.stopDiscovery();
    await subscription.cancel();
    _bluetoothSearching.value = false;
  }

  // fungsi inisialisasi bluetooth
  Future<void> setupBluetooth() async {
    _allBluetooth.streamBluetoothState.listen((bs) {
      _bluetoothEnabled.value = bs;
      if (bs) {
        Get.snackbar("ON", "Bluetooth aktif.");
      } else {
        Get.snackbar("OFF", "Bluetooth tidak aktif.");
      }
    });

    if (await _allBluetooth.isBluetoothOn()) {
      return;
    }

    // show an error to the user, etc
    Get.snackbar("Permission", "Izinkan aplikasi ini untuk akses bluetooth!");
  }

  // ============================================ PROPERTI AREA ============================
  // setter and getter for bluetooth searching
  bool get isScanning => _bluetoothSearching.value;
  BluetoothDevice? get connectedDevice => _connectedDevice;

  List<BluetoothDevice> get devices => _devices;
  set devices(List<BluetoothDevice> newList) => _devices.assignAll(newList);

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
