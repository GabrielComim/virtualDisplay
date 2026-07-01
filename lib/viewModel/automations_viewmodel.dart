import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:virtual_display/helpers/database_helper.dart';
import 'package:virtual_display/models/automation.dart';

class AutomationsViewmodel extends ChangeNotifier {
  // ================= AUTOMAÇÕES =================
  List<Automation> _automation = [];
  List<Automation> get automations => _automation;

  Future<void> loadAutomations() async {
    _automation = await DatabaseHelper.instance.getAutomation();
    notifyListeners();
  }
  
  // Salva os novos dados da automação
  Future<void> addNewAutomation(Automation automation) async {  
    await DatabaseHelper.instance.insertAutomation(automation);
    await loadAutomations();
  }
  // Exclui uma automação
  Future<void> removeAutomation(int automationId) async {
    await DatabaseHelper.instance.deleteAutomation(automationId);
    await loadAutomations();
  }
  // Edita
  Future<void> updateAutomation(Automation automation) async {
    log('SALVANDO AUTOMAÇÃO: ${automation.id}');
    await DatabaseHelper.instance.updateAutomation(automation);
    await loadAutomations();
  }
}