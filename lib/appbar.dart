import 'package:flutter/material.dart';
import 'package:test/alert.dart';
import 'package:test/login.dart';
import 'package:test/share.dart';

AppBar buildAppbar(
  BuildContext context,
  String title,
) {
  var loggedIn = Share.isLoggedIn;

  login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    ).then(
      (value) => Share.updateState(Share.isLoggedIn),
    );
  }

  logout() {
    Share.updateState(false);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  return AppBar(
    title: Text(title),
    actions: [
      !loggedIn
          ? IconButton(
              icon: const Icon(Icons.login),
              onPressed: login,
            )
          : IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => alert(
                context,
                title: 'Logout',
                content: 'Are you sure?',
                okAction: logout,
                showCancel: true,
              ),
            ),
    ],
  );
}
