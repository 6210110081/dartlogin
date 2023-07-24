import 'package:flutter/material.dart';
import 'package:test/appbar.dart';
import 'package:test/share.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var text = !Share.isLoggedIn
        ? 'แอปนี้จำเป็นจ้องเข้าสู่ระบบ \n ก่อนการใช้งานในเพจต่างๆ \n\n แตะที่ไอค่อนมุมขวาบน \n เพื่อเข้สู่ระบบ'
        : 'ท่านเข้าสู่ระบบแล้ว\n\nแต่ที่ไอคอมมุมขวาบน\nเพื่อออกจากระบบ';

    var icon = !Share.isLoggedIn ? Icons.lock_rounded : Icons.check;

    Share.updateState = (value) {
      setState(() {
        Share.isLoggedIn = value;
      });
    };

    return Scaffold(
      appBar: buildAppbar(context, 'Login'),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Icon(icon, size: 64),
            const SizedBox(height: 30),
            Text(text, textScaleFactor: 1.7),
          ],
        ),
      ),
    );
  }
}
