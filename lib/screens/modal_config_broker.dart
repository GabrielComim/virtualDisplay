import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/helpers/database_helper.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/viewModel/credential_viewmodel.dart';

Future<void> modalConfigBroker(BuildContext context) async {
  final brokerController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool tls = false;

  await showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return SafeArea(
            child: SingleChildScrollView(
              // Campo para alterar o broker MQTT
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.configAdvanced,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: brokerController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.mqttBroker,
                      labelStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: ColorScheme.of(context).secondary),
                      helperText:
                          '${AppLocalizations.of(context)!.example} URL_BROKER.s1.eu.hivemq.cloud',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.credentialName,
                      labelStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: ColorScheme.of(context).secondary),
                      helperText: AppLocalizations.of(context)!.usernameBroker,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        context,
                      )!.credentialPassword,
                      labelStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: ColorScheme.of(context).secondary),
                      helperText: AppLocalizations.of(context)!.passwordBroker,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.tls,
                        style: TextStyle(
                          color: ColorScheme.of(context).secondary,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 4),
                      Checkbox(
                        activeColor: ColorScheme.of(context).secondary,
                        onChanged: (value) {
                          setModalState(() {
                            tls = value!;
                          });
                        },
                        value: tls,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.ok),
                    onPressed: () async {
                      // Salvar o novo broker MQTT
                      final credentials = CredentialsBroker(
                        broker: brokerController.text.trim(),
                        username: usernameController.text.trim(),
                        password: passwordController.text.trim(),
                        tls: tls,
                      );
                      await context.read<CredentialViewmodel>().addNewBroker(credentials);
                      //Teste para ver se gravou as informações. Buscar no banco os valores e printar num log
                      await DatabaseHelper.instance
                          .getCredential()
                          .then((savedCredentials) {
                            final saved = savedCredentials.isNotEmpty
                                ? savedCredentials.last
                                : null;

                            log('Credenciais salvas no banco:');
                            if (saved != null) {
                              if (context.mounted) {
                                Navigator.pop(context, true);
                              }
                            } else {
                              log(
                                'Nenhuma credencial encontrada após o salvamento.',
                              );
                              if (context.mounted) {
                                Navigator.pop(context, false);
                              }
                            }
                          })
                          .catchError((error) {
                            log('Erro ao buscar credenciais no banco: $error');
                          });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
