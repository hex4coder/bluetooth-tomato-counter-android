import 'package:get/get.dart';

// data service
class BluetoothDataService extends GetxService {
  // obs data
  final _connected = false.obs;

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