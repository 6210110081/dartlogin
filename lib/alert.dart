import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

void alert(
  BuildContext context, {
  String title = '',
  String content = '',
  Function? okAction,
  bool showCancel = false,
}) {
  okPress() {
    Navigator.of(context).pop();
    okAction!();
  }

  cancelPressed() {
    Navigator.of(context).pop();
  }

  var textTitle = Text(title, textScaleFactor: 1.5);
  var textContent = Text(content, textScaleFactor: 1.3);
  var textOk = const Text('OK', textScaleFactor: 1.3);
  var textCancel = const Text('Cancel', textScaleFactor: 1.3);

  if (Platform.isAndroid) {
    var btnOK = TextButton(
      onPressed: okPress,
      child: textOk,
    );

    var btnCancel = TextButton(
      onPressed: cancelPressed,
      child: textCancel,
    );

    var btns = <TextButton>[btnOK];
    showCancel ? btns.add(btnCancel) : null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: textTitle,
        content: textContent,
        actions: btns,
      ),
    );
  } else if (Platform.isIOS) {
    var btnOK = CupertinoDialogAction(
      onPressed: okPress,
      child: textOk,
    );

    var btnCancel = CupertinoDialogAction(
      onPressed: cancelPressed,
      child: textCancel,
    );

    var btns = <CupertinoDialogAction>[btnOK];
    showCancel ? btns.add(btnCancel) : null;

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: textTitle,
        content: textContent,
        actions: btns,
      ),
    );
  }
}
