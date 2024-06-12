import 'package:chat_app/const/color.dart';
import 'package:flutter/material.dart';

class DialogWidgets {
  final BuildContext context;

  DialogWidgets(this.context);

  void showWaitingDialog({String message = "Please wait..."}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  void hideWaitingDialog() {
    Navigator.of(context).pop();
  }

  void showSuccessDialog({String message = "Operation successful!"}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle),
          title: const Text("Success"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog({String message = "An error occurred!"}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: TColor.error1),
                  SizedBox(width: 8),
                  Text(
                    'ERROR',
                    style: TextStyle(
                      fontSize: 20,
                      color: TColor.error1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(color: TColor.prime1),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
