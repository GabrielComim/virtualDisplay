import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:virtual_display/models/device_info.dart';

class DevicesViewModel extends ChangeNotifier{
  DevicesViewModel() {
    log('DevicesViewModel criado: ${identityHashCode(this)}');
  }
  final List<DeviceInfo> devices = [];
  

  void addDevice(DeviceInfo device) {
    log('Adicionando dispositivo: ${device.device}');
    // Filtro que não permite a criação de outro dispositivo com o mesmo nome
    final exists = devices.any(
      (d) => d.device == device.device,
    );
    if(!exists) {
      // Adiciona um dispositivo novo - Conforme o que foi reebido via MQTT em Topic: .../response_devices: "device"
      devices.add(device);
      log('Total dispositivos: ${devices.length}');
      notifyListeners();
    }
  }
}