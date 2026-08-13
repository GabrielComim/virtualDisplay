import 'package:flutter/material.dart';
import 'package:virtual_display/widgets/confirm_delete.dart';

Widget deleteWithSlideWidget(
  BuildContext context,
  {required int id,                         // Identifica o item
  required final VoidCallback onDismissed,  // Função a ser executada quando a exclusão for confirmada
  required Widget child,                    // Widget que quero tornar deslizável
}) {
  // Widget para deslizar lateralmente
  return Dismissible(
    key: ValueKey(id),
    direction: DismissDirection.endToStart,
    background: Container(
      color: ColorScheme.of(context).primary,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 30),
      child: Icon(Icons.delete, color: ColorScheme.of(context).error),
    ),
    confirmDismiss: (direction) async {
      return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return confirmDeleteDialog(context);
        },
      );
    },
    onDismissed: (direction) {
      onDismissed();
    },
    child: child,
  );
}
