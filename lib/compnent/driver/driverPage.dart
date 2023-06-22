// ignore_for_file: file_names, camel_case_types, use_build_context_synchronously

import 'package:animated_sidebar/animated_sidebar.dart';
import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/compnent/driver/driverHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Conaction.dart';


class driverPage extends StatefulWidget {
  const driverPage({Key? key}) : super(key: key);

  @override
  State<driverPage> createState() => _driverPageState();
}

class _driverPageState extends State<driverPage> {
  int activeTab = 0;
  final List screen=[
    const driverHomePage(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.witheBackColor,
      body: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Conaction()), (route) => false);
            }, icon: const Icon(Icons.logout))
          ],
        ),

        body: Row(
          children: [
            Expanded(
                child: screen[0]
            ),
          ],
        ),
      ),
    );
  }
}
