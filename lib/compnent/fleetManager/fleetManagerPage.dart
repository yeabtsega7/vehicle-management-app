// ignore_for_file: file_names, camel_case_types, use_build_context_synchronously

import 'package:animated_sidebar/animated_sidebar.dart';
import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/compnent/driver/driverReportPage.dart';
import 'package:bit_vehicle_web/compnent/fleetManager/fleetManagerHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Conaction.dart';


class fleetManagerPage extends StatefulWidget {
  const fleetManagerPage({Key? key}) : super(key: key);

  @override
  State<fleetManagerPage> createState() => _fleetManagerPageState();
}

class _fleetManagerPageState extends State<fleetManagerPage> {
  int activeTab = 0;
  final List<SidebarItem> items = [
    SidebarItem(
      icon: Icons.home,
      text: 'Home',
    ),
    SidebarItem(
      icon: Icons.newspaper,
      text: 'Report',
    ),
  ];
  final List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.newspaper),
      label: 'Report',
    ),
  ];
  final List screen=[
    const fleetManagerHomePage(),
    const driverReportPage()
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
        // bottomNavigationBar: MediaQuery.of(context).size.width<=560? Theme(
        //   data: Theme.of(context).copyWith(
        //     // sets the background color of the `BottomNavigationBar`
        //       canvasColor: AppColors.blackFontColor,
        //       // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        //       primaryColor: Colors.red,
        //       textTheme: Theme
        //           .of(context)
        //           .textTheme
        //           .copyWith(bodySmall:  const TextStyle(color: Colors.yellow))
        //   ),
        //   child: BottomNavigationBar(
        //     selectedItemColor:Colors.grey.withOpacity(0.3),
        //     currentIndex: activeTab,
        //     onTap: (i){
        //       setState(() {
        //         activeTab=i;
        //       });
        //     },
        //
        //     items: bottomItems,
        //   ),
        // ):null,
        body: Row(
          children: [
            // if(MediaQuery.of(context).size.width>560)
            //   AnimatedSidebar(
            //     margin: const EdgeInsets.all(0),
            //     expanded: MediaQuery.of(context).size.width > 600?true:false,
            //     items: items,
            //     selectedIndex: activeTab,
            //     autoSelectedIndex: false,
            //     onItemSelected: (index) => setState(() => activeTab = index),
            //     duration: const Duration(milliseconds: 100),
            //     frameDecoration: const BoxDecoration(
            //       color: AppColors.blackFontColor,
            //     ),
            //     minSize: 90,
            //     maxSize: 250,
            //     itemIconSize: 26,
            //     itemIconColor: Colors.white,
            //     itemHoverColor: Colors.grey.withOpacity(0.3),
            //     itemSelectedColor: Colors.grey.withOpacity(0.3),
            //     itemTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            //     itemSelectedBorder: const BorderRadius.all(
            //       Radius.circular(5),
            //     ),
            //     itemMargin: 16,
            //     itemSpaceBetween: 10,
            //     headerIcon: Icons.ac_unit_sharp,
            //     headerIconSize: 50,
            //     headerIconColor: Colors.amberAccent,
            //     headerTextStyle: const TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white),
            //     headerText: 'BiT Vehicle Management System',
            //   ),
            Expanded(
                child: screen[0]
            ),
          ],
        ),
      ),
    );
  }
}
