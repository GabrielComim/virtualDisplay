import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:virtual_display/models/device_info.dart';

class DevicesViewModel extends ChangeNotifier{
  
  DevicesViewModel() {
    log('DevicesViewModel criado: ${identityHashCode(this)}');
  }
  
  final List<DeviceInfo> _devices = [];

  List<DeviceInfo> get devices => List.unmodifiable(_devices);

  List<DeviceInfo> getDevices(int brokerId) {
    return _devices.where((device) => device.brokerId == brokerId).toList();
  }
  

  void addDevice(DeviceInfo device) {
    log('Adicionando dispositivo: ${device.device}');
    // Filtro que não permite a criação de outro dispositivo com o mesmo nome
    final exists = _devices.any(
      (d) => 
        d.brokerId == device.brokerId && 
        d.device == device.device,
    );
    if(!exists) {
      // Adiciona um dispositivo novo - Conforme o que foi reebido via MQTT em Topic: .../response_devices: "device"
      _devices.add(device);
      log('Total dispositivos: ${_devices.length}');
      notifyListeners();
    }
  }

  // Faz a exclusão de um dispositivo da lista
  void removeDevice(DeviceInfo device) {
    log('Removendo dispositivo: ${device.device}');
    // Filtro que remove o dispositivo da lista, verifica se é do broker correto e o nome do dispositivo é o mesmo
    _devices.removeWhere(
      (d) => 
        d.brokerId == device.brokerId && 
        d.device == device.device,
    );
    log('Total dispositivos: ${_devices.length}');
    notifyListeners();
  }
}