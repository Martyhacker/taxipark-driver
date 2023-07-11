import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class OkDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onOkTap;
  const OkDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onOkTap});

  @override
  Widget build(BuildContext context) {
    AlertDialog androidDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Отмена',
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              onOkTap.call();
              Navigator.pop(context);
            },
            child: const Text("OK"))
      ],
    );
    CupertinoAlertDialog iosDialog = CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Отмена',
              style: TextStyle(color: Colors.red),
            )),
        CupertinoDialogAction(
            onPressed: () {
              onOkTap.call();
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
    );
    return Platform.isIOS ? iosDialog : androidDialog;
  }
}
