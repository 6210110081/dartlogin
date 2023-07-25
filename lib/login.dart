import 'package:flutter/material.dart';
import 'appbar.dart';
import 'api.dart';
import 'share.dart';
import 'alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _ctrlLogin = TextEditingController();
  final _ctrlPswd = TextEditingController();
  var _apiCalling = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: (!Share.isLoggedIn)
          ? AppBar(title: const Text('เข้าสู่ระบบ'))
          : buildAppbar(context, ''),
      body: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          alignment: Alignment.topCenter,
          child: (!Share.isLoggedIn)
              ? columnLogin()
              : const Text(
                  'ท่านเข้าสู่ระบบแล้ว\n\n'
                  'หากต้องการออกจากระบบ\n'
                  'ให้แตะไอคอนมุมขวาบน',
                  textScaleFactor: 1.7,
                )));

  Widget columnLogin() => Column(children: [
        const SizedBox(height: 30),
        SizedBox(width: 300, child: textFieldLogin()),
        const SizedBox(height: 20),
        SizedBox(width: 300, child: textFieldPswd()),
        const SizedBox(height: 20),
        btnOK(),
        const SizedBox(height: 30),
        const Text(
          '* ใส่ค่าอะไรก็ได้ที่ไม่ใช่ช่องว่าง *',
          textScaleFactor: 1.3,
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        )
      ]);

  OutlineInputBorder outlineBorder() => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2));

  TextStyle textStyle() => const TextStyle(
      color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.normal);

  Widget textFieldLogin() => TextField(
        controller: _ctrlLogin,
        decoration: InputDecoration(
          border: outlineBorder(),
          hintText: 'ชื่อผู้ใช้',
        ),
        style: textStyle(),
      );

  Widget textFieldPswd() => TextField(
        controller: _ctrlPswd,
        decoration: InputDecoration(
          border: outlineBorder(),
          hintText: 'รหัสผ่าน',
        ),
        obscureText: true,
        style: textStyle(),
      );

  Widget btnOK() => TextButton(
      onPressed: btnOK_pressed,
      child: (_apiCalling)
          ? const CircularProgressIndicator()
          : const Text('เข้าสู่ระบบ', textScaleFactor: 1.7));

  void btnOK_pressed() {
    setState(() => _apiCalling = true);

    late Future<Map<String, dynamic>> futureLogin;
    futureLogin = apiLogin(_ctrlLogin.text, _ctrlPswd.text);

    futureLogin.then((value) {
      setState(() {
        if (value['result'] == true) {
          Share.isLoggedIn = true;
        } else {
          Share.isLoggedIn = false;
          alert(
            context,
            title: '',
            content: 'ชื่อหรือรหัสผ่านไม่ถูกต้อง',
            okAction: (context) {
              Navigator.of(context).pop();
            },
            showCancel: false,
          );
        }
        _apiCalling = false;
      });
    });
  }
}
