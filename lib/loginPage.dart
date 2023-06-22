// ignore_for_file: use_build_context_synchronously

import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/compnent/dispatcher/dispatcherPage.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:bit_vehicle_web/model/Dispacture.dart';
import 'package:bit_vehicle_web/model/Driver.dart';
import 'package:bit_vehicle_web/model/Manager.dart';
import 'package:bit_vehicle_web/model/OfficeManager.dart';
import 'package:bit_vehicle_web/model/Users.dart';
import 'package:bit_vehicle_web/resetUserPassword.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'compnent/driver/driverPage.dart';
import 'compnent/fleetManager/fleetManagerPage.dart';
import 'compnent/officeManager/officeManagerPage.dart';
import 'compnent/user/userPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
   final emailFiledControler=TextEditingController();
   final passwordFiledControler=TextEditingController();
   bool showPassword=true;
   IconData icon=Icons.visibility_outlined;
   String errorMassage="";
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(showPassword){
      icon=Icons.visibility_off_outlined;
    }else{
       icon=Icons.visibility_outlined;
    }
    return Scaffold(
      backgroundColor: AppColors.witheBackColor,
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: height,
                  padding: EdgeInsets.symmetric(horizontal: height * 0.03 ),
                  decoration: MediaQuery.of(context).size.width<=830?const BoxDecoration(
                    color: AppColors.darkBckColor,
                    image: DecorationImage(
                        alignment: Alignment(-1.0, 0),
                        image: AssetImage('assets/images/vehicle.png')
                    ),
                  ):const BoxDecoration(),
                  child:  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text("Log In",style: TextStyle(fontSize: 40,color: AppColors.blackFontColor),),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Email",style: TextStyle(fontSize: 20,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
                            const SizedBox(height: 16,),
                            Container(
                              // width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColors.whiteFontColor
                              ),
                              child: TextFormField(
                                controller: emailFiledControler,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Enter Email"
                                ),
                              ),
                            ),
                            const SizedBox(height: 16,),
                            const Text("Password",style: TextStyle(fontSize: 20,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
                            const SizedBox(height: 16,),
                            Container(
                              // width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColors.whiteFontColor
                              ),
                              child: TextFormField(
                                controller: passwordFiledControler,
                                obscureText: showPassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.password),
                                  suffixIcon: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          showPassword=!showPassword;
                                        });
                                      },
                                      icon: Icon(icon)
                                  )
                                ),
                              ),
                            ),
                            const SizedBox(height: 16,),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const resetUserPassword()));
                            }, child: const Text("Forgot Password")),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(errorMassage,style: const TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FilledButton(
                                    onPressed: (){
                                      login();
                                    },
                                    child: const Text("Log In")
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if(MediaQuery.of(context).size.width>830)
              Expanded(
                child: Container(
                  height: height,
                  alignment: FractionalOffset.centerLeft,
                  decoration:  const BoxDecoration(
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
   Future login() async {
    if(EmailValidator.validate(emailFiledControler.text.trim())&&passwordFiledControler.text.isNotEmpty){
     try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailFiledControler.text.trim(), password: passwordFiledControler.text.trim())
       .then((value) async {
         print("signed in");
          print(firebaseCone.currentUserUid);
         var isUser=await Users.login(firebaseCone.currentUserUid,context);
         var isDriver=await Driver.login(firebaseCone.currentUserUid);
         var isFleetManager=await FleetManager.login(firebaseCone.currentUserUid);
         var isOfficeManager=await OfficeManager.login(firebaseCone.currentUserUid);
         var isDispatcur=await Dispatcher.login(firebaseCone.currentUserUid);
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

       }).onError((error, stackTrace) {
         print("sign in error:");
         print(error);
       });

     }on FirebaseAuthException catch (e){
       print("FirebaseAuthException");
       print(e);
       errorMassage=e.message!;
     }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.height) * 0.18),
          backgroundColor: Colors.red,
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wrong input try agan")
              ],
            ))
      );
    }
   }
}
