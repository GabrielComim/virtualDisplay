import 'package:flutter/material.dart';
import 'package:virtual_display/models/device_info.dart';

class DevicesViewModel extends ChangeNotifier{
  final List<DeviceInfo> devices = [];
  
  void addDevice(DeviceInfo device) {
    devices.add(device);
    notifyListeners();
  }
}