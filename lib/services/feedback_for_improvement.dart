import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';

Future<void> sendFeedback(String message) async {
  try {
    await FirebaseFirestore.instance.collection('feedbacksForImprovement').add({
      'message': message,
      'created_at': FieldValue.serverTimestamp(),
    });
      log("Feedback enviado com sucesso!");
  } catch (e) {
    log("Erro ao enviar feedback: $e");
  }
}

void feedbackForImprovement(BuildContext context) {
  final TextEditingController controllerAnswer = TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(AppLocalizations.of(context)!.questionFeedback),
            content: TextField(
              controller: controllerAnswer,
              maxLines: 5,
            ),
            actions: [
              // BOTÃO CANCELAR
              TextButton(
                  child: Text(AppLocalizations.of(context)!.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              // BOTÃO ENVIAR
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.send),
                onPressed: () async {
                  final text = controllerAnswer.text.trim();
                  if (text.isEmpty) return;
                  await sendFeedback(text);
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
              ),
            ]);
      });
}
