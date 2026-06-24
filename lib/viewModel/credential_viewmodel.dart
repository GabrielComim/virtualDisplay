import 'package:flutter/material.dart';
import 'package:virtual_display/helpers/database_helper.dart';
import 'package:virtual_display/models/credentials_broker.dart';

class CredentialViewmodel extends ChangeNotifier {
  // ================= CREDENTIALS BROKER =================
  List<CredentialsBroker> _credentials = [];
  List<CredentialsBroker> get credentials => _credentials;

  Future<void> loadCredentials() async {
    _credentials = await DatabaseHelper.instance.getCredential();
    notifyListeners();
  }
  
  // Salva os novos dados do broker
  Future<void> addNewBroker(CredentialsBroker credential) async {  
    await DatabaseHelper.instance.insertCredentials(credential);
    await loadCredentials();
  }
  // Exclui uma conexão broker
  Future<void> removeCredentialsBroker(CredentialsBroker credential) async {
    await DatabaseHelper.instance.deleteCredential(credential.id!);
    await loadCredentials();
  }
  // Edita
  Future<void> updateCredential(CredentialsBroker credential) async {
    await DatabaseHelper.instance.updateCredential(credential);
    notifyListeners();
  }

}