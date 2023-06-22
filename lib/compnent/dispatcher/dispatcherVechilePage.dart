// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../AppColors.dart';
import '../vechileCard.dart';

class dispatcherVechilePage extends StatefulWidget {
  const dispatcherVechilePage({Key? key}) : super(key: key);

  @override
  State<dispatcherVechilePage> createState() => _dispatcherVechilePageState();
}

class _dispatcherVechilePageState extends State<dispatcherVechilePage> {



  @override
  Widget build(BuildContext context) {
      return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:ListView(
        children: [
          Container(
            // height: 1000,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:   [
                const Expanded(
                    flex: 2,
                    child: viewUsers()
                ),
                if(MediaQuery.of(context).size.width>550)
                const Expanded(
                  child: AddVechile(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class viewUsers extends StatefulWidget {
  const viewUsers({Key? key}) : super(key: key);

  @override
  State<viewUsers> createState() => _viewUsersState();
}

class _viewUsersState extends State<viewUsers> {

  var selectedPage=1;
  String? usersOrderedBy = "vechileModel";
  List usersOrderedByList = [
    "vechileModel",
    "manufacturingDate"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Vechile",
            style: TextStyle(
                fontSize: 30, color: AppColors.blackFontColor),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(0),
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
                            "All Vechile",
                            style: TextStyle(fontSize: 17),
                          ),
                          if(MediaQuery.of(context).size.width<=550)
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddVechileLess()));
                            }, icon: const Icon(Icons.add))
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Text("Order By :"),
                          DropdownButton(
                              value: usersOrderedBy,
                              items: usersOrderedByList.map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              onChanged: (n) {
                                setState(() {
                                  usersOrderedBy = n as String?;
                                });
                              }),
                        ],
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: firebaseCone
                              .vehiclesRef
                              .orderBy(usersOrderedBy!)
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
                                  physics:
                                  const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    int i=(selectedPage-1)*20+index;

                                    return vechileCard(doc: data[i]);
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
                          })
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


class AddVechile extends StatefulWidget {
  const AddVechile({Key? key}) : super(key: key);

  @override
  State<AddVechile> createState() => _AddVechileState();
}

class _AddVechileState extends State<AddVechile> {
  final plateNumberFiledControler = TextEditingController();
  final vechileModelFiledControler = TextEditingController();
  final engineNumberFiledControler = TextEditingController();
  final manufacturingDateFiledControler = TextEditingController();
  String plateNumber="";
  String vechileModel="";
  String engineNumber="";
  String manufacturingDate="";

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
        manufacturingDateFiledControler.text=pickedDate.toString().split(" ")[0];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add New Vechile",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          const Divider(),

          const SizedBox(height: 20,),
          const Text("Vechile Model",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
          const SizedBox(height: 10,),
          Container(
            // width: width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteFontColor
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: vechileModelFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.logo_dev),
                  hintText: "vechile Model"
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(vechileModel,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),
          const SizedBox(height: 10,),
          const Text("Plate Number",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
          const SizedBox(height: 10,),
          Container(
            // width: width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteFontColor
            ),
            child: TextFormField(
              controller: plateNumberFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.numbers),
                  hintText: "Plate Number"
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(plateNumber,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),
          const SizedBox(height: 10,),

          const Text("Engine Number",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
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
              controller: engineNumberFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.confirmation_number_outlined),
                  hintText: "Engine Number"
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(engineNumber,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),const SizedBox(height: 10,),
          const Text("Manufacture Date",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
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
              controller: manufacturingDateFiledControler,

              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.date_range_outlined),
                  hintText: "Phone Number"
              ),
              onTap: pickDate,
              readOnly: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(manufacturingDate,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                  onPressed: (){
                    setState(() {
                      addVechileToDb();
                    });
                  },
                  child: const Text("Add Vechile")
              )
            ],
          )
        ],
      ),
    );
  }


  Future<void> addVechileToDb() async {

    if(AddVechileValidation()){
      try {
        firebaseCone.vehiclesRef.add({
          "plateNumber":plateNumberFiledControler.text,
          "vechileModel":vechileModelFiledControler.text,
          "engineNumber":engineNumberFiledControler.text,
          "manufacturingDate":Timestamp.fromMillisecondsSinceEpoch(pickedDate!.millisecondsSinceEpoch),
          "assigned":false
        })
            .then((value){

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text( "Vechile Added",style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.green,)
          );
        })
            .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text( "Failed to add Vechile: $error",style: const TextStyle(color: Colors.white),),
                backgroundColor: Colors.red,)
          );
        });
      } catch (e) {
      }
    }
    else{
    }
    plateNumberFiledControler.clear();
    vechileModelFiledControler.clear();
    engineNumberFiledControler.clear();
    manufacturingDateFiledControler.clear();
    if(MediaQuery.of(context).size.width<=500){
      Navigator.pop(context);
    }
  }


  bool AddVechileValidation(){
    bool valid =true;
    if(vechileModelFiledControler.text.trim()==""){
      setState(() {
        vechileModel="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        vechileModel="";
      });
    }
    if(plateNumberFiledControler.text.trim()==""){
      setState(() {
        plateNumber="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        plateNumber="";
      });
    }
    if(engineNumberFiledControler.text.trim()==""){
      setState(() {
        engineNumber="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        engineNumber="";
      });
    }
    if(pickedDate==null){
      setState(() {
        manufacturingDate="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        manufacturingDate="";
      });
    }

    return valid;
  }

}



class AddVechileLess extends StatefulWidget {
  const AddVechileLess({Key? key}) : super(key: key);

  @override
  State<AddVechileLess> createState() => _AddVechileLessState();
}

class _AddVechileLessState extends State<AddVechileLess> {
  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width>560){
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: const AddVechile(),
    );
  }
}