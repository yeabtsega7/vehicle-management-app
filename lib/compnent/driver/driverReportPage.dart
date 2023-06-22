// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

import '../../AppColors.dart';

class driverReportPage extends StatefulWidget {
  const driverReportPage({Key? key}) : super(key: key);

  @override
  State<driverReportPage> createState() => _driverReportPageState();
}

class _driverReportPageState extends State<driverReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const form()
      ),
    );
  }
}

class form extends StatefulWidget {
  const form({Key? key}) : super(key: key);

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final userEmailFiledControler=TextEditingController();
  String emailError="";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        const Text("Report page",style: TextStyle(fontSize: 30),),
        const Drawer(),
        Column(
          children: [
            const Text("Email",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: userEmailFiledControler,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emailError,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),const SizedBox(height: 10,),
            const Text("Email",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: userEmailFiledControler,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emailError,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),const SizedBox(height: 10,),
            const Text("Email",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: userEmailFiledControler,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emailError,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),const SizedBox(height: 10,),
            const Text("Email",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: userEmailFiledControler,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emailError,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),const SizedBox(height: 10,),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: (){
                      setState(() {
                        generateReport();
                      });
                    },
                    child: const Text("Generate Report")
                )
              ],
            )
          ],
        )
      ],
    );
  }

  void generateReport() {

  }
}
