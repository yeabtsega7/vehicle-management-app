import 'package:bit_vehicle_web/compnent/dispatcher/dispatcherPage.dart';
import 'package:bit_vehicle_web/compnent/driver/driverPage.dart';
import 'package:bit_vehicle_web/compnent/fleetManager/fleetManagerPage.dart';
import 'package:bit_vehicle_web/compnent/officeManager/officeManagerPage.dart';
import 'package:bit_vehicle_web/compnent/user/userPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'loginPage.dart';
import 'model/Dispacture.dart';
import 'model/Driver.dart';
import 'model/Manager.dart';
import 'model/OfficeManager.dart';
import 'model/Users.dart';

class Conaction extends StatefulWidget {
  const Conaction({Key? key}) : super(key: key);

  @override
  State<Conaction> createState() => _ConactionState();
}

class _ConactionState extends State<Conaction> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return  Row(
              children: [
                Expanded(child: Container(
                    decoration:   const BoxDecoration(
                      color: AppColors.darkBckColor,
                      image: DecorationImage(
                          alignment: Alignment(-1.0, 0),
                          image: AssetImage('assets/images/vehicle.png')
                      ),
                    ),
                    child:  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/BitLogo.png'),
                          const SizedBox(
                            height: 50,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("BiT",style: TextStyle(fontSize: 70,color: AppColors.redFontColor),),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Vehicle",style: TextStyle(fontSize: 50,color: AppColors.whiteFontColor),)
                            ],
                          ),const SizedBox(
                            height: 20,
                          ),
                          const Text("Management System",style: TextStyle(fontSize: 35,color: AppColors.whiteFontColor),)
                        ],
                      ),
                    )
                ))
              ],
            );
        }
        if(snapshot.connectionState==ConnectionState.done){
          return const Center(
            child: Text("none"),
          );
        }
        if(snapshot.hasError){
          return const Center(

            child: Text("failed to connect"),
          );
        }
        if(snapshot.hasData){
          print("logd in");
          // FirebaseAuth.instance.signOut();
          // return const loginPage();
          pageTo(snapshot);
        }else{
          print("not logd");
          return const loginPage();
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );

      },
    );
  }
  pageTo(AsyncSnapshot snapshot) async {
    var isUser=await Users.login(snapshot.data!.uid,context);
    var isDriver=await Driver.login(snapshot.data!.uid);
    var isFleetManager=await FleetManager.login(snapshot.data!.uid);
    var isOfficeManager=await OfficeManager.login(snapshot.data!.uid);
    var isDispatcur=await Dispatcher.login(snapshot.data!.uid);
    if(isUser!=null){
      print('user');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const userPage()), (route) => false);
    }else if(isDriver!=null){
      print('Driver');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const driverPage()), (route) => false);
    }else if(isDispatcur!=null){
      print('dispatcur');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const dispatcherPage()), (route) => false);
    }else if(isOfficeManager!=null){
      print('officeManager');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const officeManagerPage()), (route) => false);
    }else if(isFleetManager!=null){
      print('fleetManager');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const fleetManagerPage()), (route) => false);
    }
    else{
      print("sign out again");
      FirebaseAuth.instance.signOut();
    }
  }
}
