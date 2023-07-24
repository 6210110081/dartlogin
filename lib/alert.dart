import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

void alert(
  BuildContext context, {
  String title = '',
  String content = '',
  Function? okAction,
  bool showCancle = false,
}) {
  okPress() {
    Navigator.of(context).pop();
    okAction!.call();
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
      onPressed: okPress.call(),
      child: textOk,
    );

    var btnCancel = TextButton(
      onPressed: cancelPressed.call(),
      child: textCancel,
    );

    var btns = <TextButton>[btnOK];
    showCancle ? btns.add(btnCancel) : null;

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
      onPressed: okPress.call(),
      child: textOk,
    );

    var btnCancel = CupertinoDialogAction(
      onPressed: cancelPressed.call(),
      child: textCancel,
    );

    var btns = <CupertinoDialogAction>[btnOK];
    showCancle ? btns.add(btnCancel) : null;

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
