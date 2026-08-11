import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/services/check_connection_internet.dart';
import 'package:virtual_display/widgets/show_material_banner.dart';

Future<void> sendFeedback(BuildContext context, String message) async {
  try {
    // Verifica a conexão com a internet antes de tentar enviar o feedback
    bool isConnection = await checkConnectionInternet(context);
    if (isConnection) {
      await FirebaseFirestore.instance
          .collection('feedbacksForImprovement')
          .add({'message': message, 'created_at': FieldValue.serverTimestamp()})
          .timeout(Duration(seconds: 10));

      log("Feedback enviado com sucesso!");
      ShowBanner.messengerShow(
        context,
        AppLocalizations.of(context)!.sendSuccess,
        false,
      );
    } else {
      throw Exception(AppLocalizations.of(context)!.errorConection);
    }
  } catch (e) {
    log("Erro ao enviar feedback: $e");
    ShowBanner.messengerShow(context, e.toString(), true);
  }
}

void feedbackForImprovement(BuildContext context) {
  final TextEditingController controllerAnswer = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.questionFeedback),
        content: TextField(controller: controllerAnswer, maxLines: 5),
        actions: [
          // BOTÃO CANCELAR
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // BOTÃO ENVIAR
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.send),
            onPressed: () async {
              final text = controllerAnswer.text.trim();
              if (text.isEmpty) return;
              await sendFeedback(context, text);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
