import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alert(BuildContext context, String message, String type) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.zero,
        backgroundColor: const Color.fromARGB(230, 230, 230, 230),
        content: SingleChildScrollView(
          child: ListBody(children: [
            Row(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Icon(
                  type == 'ERROR'
                      ? Icons.error
                      : type == 'SUCCESS'
                          ? Icons.check_circle
                          : Icons.info,
                  color: type == 'ERROR'
                      ? Colors.red
                      : type == 'SUCCESS'
                          ? Colors.lightGreen
                          : Colors.lightBlue,
                  size: 32,
                ),
              ),
            ]),
            Text(message,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ]),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[500]!, width: 0.3),
                  ),
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 12, bottom: 12),
                child: const Text(
                  '닫기',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 255), fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
