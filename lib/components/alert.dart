import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alert(BuildContext context, String message, String type) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: ListBody(children: [
            Row(children: [
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
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
            Text(message, style: const TextStyle(fontSize: 16)),
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
                    top: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 12, bottom: 12),
                child: const Text(
                  '닫기',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center, // 텍스트 중앙 정렬
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
