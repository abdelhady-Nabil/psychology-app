import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';
class VisaScreen extends StatefulWidget {
  const VisaScreen({Key? key}) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        title: Text('Visa الدفع عن طريق '),
      ),
    );
  }
}
