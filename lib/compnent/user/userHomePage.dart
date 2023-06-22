// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:bit_vehicle_web/compnent/user/userRequestCard.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../AppColors.dart';

class userHomePage extends StatefulWidget {
  const userHomePage({Key? key}) : super(key: key);

  @override
  State<userHomePage> createState() => _userHomePageState();
}

class _userHomePageState extends State<userHomePage> {
  var selectedPage=1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        "Requests",
                        style: TextStyle(
                            fontSize: 45, color: AppColors.blackFontColor),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              // height: 150,
                              // height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.witheColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "My Requests",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      if(MediaQuery.of(context).size.width<=560)
                                        IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddRequestLess()));}, icon: const Icon(Icons.add))
                                    ],
                                  ),
                                  const Divider(),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: firebaseCone.serviceRef
                                          .where("reqID",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                          snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                            "Error",
                                            style:
                                            TextStyle(color: Colors.red),
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                              CircularProgressIndicator());
                                        }
                                        if (!snapshot.hasData) {
                                          return const Text(
                                            "no data ",
                                            style:
                                            TextStyle(color: Colors.blue),
                                          );
                                        }
                                        final data = snapshot.data!.docs;


                                        int numOfData=20;
                                        int numOfPages=(data.length/numOfData).ceil();


                                        return Column(
                                          children: [
                                            ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: data.length-(selectedPage*20)>=0?20:data.length%20,
                                              itemBuilder: (context, index) {
                                                int i=(selectedPage-1)*20+index;
                                                return userRequestCard(
                                                  doc: data[i],
                                                );
                                              },
                                            ),
                                            Pagination(
                                              numOfPages: numOfPages,
                                              selectedPage: selectedPage,
                                              pagesVisible: 5,
                                              onPageChanged: (page) {
                                                setState(() {
                                                  selectedPage = page;
                                                });
                                              },
                                              nextIcon: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                                size: 14,
                                              ),
                                              previousIcon: const Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.black,
                                                size: 14,
                                              ),
                                              activeTextStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              activeBtnStyle: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.black54),
                                                shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(38),
                                                  ),
                                                ),
                                              ),
                                              inactiveBtnStyle: ButtonStyle(
                                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(38),
                                                )),
                                              ),
                                              inactiveTextStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            if(MediaQuery.of(context).size.width>550)
            const Expanded(child: AddRequest())
          ],
        ),
      ),
    );
  }
}

class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {

  final _puropuseOfServiceTextFieldController=TextEditingController();
  final _requestedBodyTextFieldController=TextEditingController();
  final _distnationTextFieldController=TextEditingController();
  final _numberOfPassangerTextFieldController=TextEditingController();
  final _endDateTextFieldController=TextEditingController();
  String puropuseOfService="";
  String requestedBody="";
  String distnation="";
  String numberOfPassanger="";
  String endDate="";
  DateTime? pickedDate;
  pickDate() async {
    pickedDate=await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );
    if(pickedDate!=null){
      setState(() {
        _endDateTextFieldController.text=pickedDate.toString().split(" ")[0];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // if(MediaQuery.of(context).size.width>560)
     return Container(
        margin: const EdgeInsets.only(top: 20,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add New Request",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            const Divider(),

            const SizedBox(height: 20,),
            const Text("Purpose Of Service",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                controller: _puropuseOfServiceTextFieldController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.cleaning_services),
                    hintText: "Purpose Of Service"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(puropuseOfService,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),
            const SizedBox(height: 10,),
            const Text("Requested Body",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                controller: _requestedBodyTextFieldController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    hintText: "Requested Body"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(requestedBody,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),
            const SizedBox(height: 10,),

            const Text("distnation",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
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
                controller: _distnationTextFieldController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.location_on),
                    hintText: "Bahir Dar"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(distnation,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),const SizedBox(height: 10,),
            const Text("Number Of Passenger",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _numberOfPassangerTextFieldController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.numbers),
                    hintText: "5"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(numberOfPassanger,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),const SizedBox(height: 10,),

            const Text("End Date",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
            const SizedBox(height: 10,),
            Container(
              // width: width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteFontColor
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _endDateTextFieldController,

                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.date_range_outlined),
                    hintText: "End Date"
                ),
                onTap: pickDate,
                readOnly: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(endDate,style: const TextStyle(color: Colors.red,fontSize: 10),)
              ],
            ),

            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: (){
                      setState(() {
                        addURequestToDb();
                      });
                    },
                    child: const Text("Send Request")
                )
              ],
            )
          ],
        ),
      );
  }


  Future<void> addURequestToDb() async {

    if(AddVechileValidation()){
      try {
        var department;
        await firebaseCone.usersRef.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
          department=value.data()!["department"];
        });
        await firebaseCone.serviceRef.add({
          "puropuseOfService":_puropuseOfServiceTextFieldController.text,
          "requestedBody":_requestedBodyTextFieldController.text,
          "distnation":_distnationTextFieldController.text,
          "numberOfPassanger":_numberOfPassangerTextFieldController.text,
          "endDate":Timestamp.fromMillisecondsSinceEpoch(pickedDate!.millisecondsSinceEpoch),
          "reqID":FirebaseAuth.instance.currentUser!.uid,
          "assignedDriver":"",
          "reportDetails":"",
          "assignedDriverName":"",

          "reported":false,
          "officeApproved":false,
          "officeDis":false,
          "officeManagerName":"",
          "fleetApproved":false,
          "fleetDis":false,
          "fleetManagerName":"",
          "department":department,
        })
            .then((value){

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text( "Request Added",style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.green,)
          );
        })
            .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text( "Failed to add Request: $error",style: const TextStyle(color: Colors.white),),
                backgroundColor: Colors.red,)
          );
        });
      } on FirebaseAuthException catch (e) {

      } catch (e) {
      }
    }
    else{
    }
    _puropuseOfServiceTextFieldController.clear();
    _requestedBodyTextFieldController.clear();
    _distnationTextFieldController.clear();
    _numberOfPassangerTextFieldController.clear();
    _endDateTextFieldController.clear();
    if(MediaQuery.of(context).size.width<=500){
      Navigator.pop(context);
    }
  }


  bool AddVechileValidation(){
    bool valid =true;
    if(_puropuseOfServiceTextFieldController.text.trim()==""){
      setState(() {
        puropuseOfService="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        puropuseOfService="";
      });
    }
    if(_requestedBodyTextFieldController.text.trim()==""){
      setState(() {
        requestedBody="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        requestedBody="";
      });
    }
    if(_distnationTextFieldController.text.trim()==""){
      setState(() {
        distnation="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        distnation="";
      });
    }
    if(_numberOfPassangerTextFieldController.text.trim()==""){
      setState(() {
        numberOfPassanger="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        numberOfPassanger="";
      });
    }
    if(pickedDate==null){
      setState(() {
        endDate="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        endDate="";
      });
    }

    return valid;
  }
}

class AddRequestLess extends StatefulWidget {
  const AddRequestLess({Key? key}) : super(key: key);

  @override
  State<AddRequestLess> createState() => _AddRequestLessState();
}

class _AddRequestLessState extends State<AddRequestLess> {
  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width>560){
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView
        (
        child:AddRequest(),
      ),
    );
  }

}
