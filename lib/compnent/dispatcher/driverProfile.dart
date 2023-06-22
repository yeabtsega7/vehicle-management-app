// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names

import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../AppColors.dart';
import 'dispatcherRequestCard.dart';

class driverProfile extends StatefulWidget {
  QueryDocumentSnapshot doc;

  driverProfile(this.doc, {Key? key}) : super(key: key);

  @override
  State<driverProfile> createState() => _driverProfileState();
}

class _driverProfileState extends State<driverProfile> {
  @override
  driverProfile get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: viewUsers(widget.doc)
                ),
                if(MediaQuery
                    .of(context)
                    .size
                    .width > 550)
                  Expanded(
                    child: AddUser(widget.doc),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}


class viewUsers extends StatefulWidget {
  QueryDocumentSnapshot doc;

  viewUsers(this.doc, {Key? key}) : super(key: key);

  @override
  State<viewUsers> createState() => _viewUsersState();
}

class _viewUsersState extends State<viewUsers> {

  var selectedPage = 1;
  String? usersOrderedBy = "firstName";
  List usersOrderedByList = [
    "firstName",
  ];
  String Search = "";
  String assignedVehicleId="";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Driver Profile",
            style: TextStyle(
                fontSize: 30, color: AppColors.blackFontColor),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          widget.doc['assignedV'] == "" ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Assign Vehicle"),
                  StreamBuilder(
                    stream: firebaseCone.vehiclesRef.where("assigned",isEqualTo: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("error");
                      }
                      if (snapshot.hasData) {
                        var data = snapshot.data!.docs;
                        String select=data.isNotEmpty?data[0].id:"no vehicle to assign";
                        return assignDriverDropDown(select,data,onChang: (String value) {
                          assignedVehicleId=value;
                        },);
                      } else {}
                      return const Text("data");
                    },
                  ),
                ],
              ),
              TextButton(onPressed: (){
                if(assignedVehicleId==""){

                }else{
                  firebaseCone.vehiclesRef.doc(assignedVehicleId).update({
                    "assigned":true
                  });
                  firebaseCone.driverRef.doc(widget.doc.id).update({
                    "assignedV":assignedVehicleId
                  });
                  Navigator.pop(context);
                }
              }, child: const Text("Assign Vehicle"))

            ],
          ) : SizedBox(
            height: 75,
            child: StreamBuilder(
              stream: firebaseCone.vehiclesRef.doc(widget.doc['assignedV']).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                var doc=snapshot.data;
                Timestamp d = doc!["manufacturingDate"];
                DateTime date =
                DateTime.fromMillisecondsSinceEpoch(d.millisecondsSinceEpoch);
                return Container(
                  color: AppColors.darkBckColor,
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(flex: 4,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                          doc["vechileModel"],
                                          style: const TextStyle(
                                              fontSize: 20, color: AppColors.whiteFontColor),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.numbers,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          doc["plateNumber"],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: AppColors.whiteFontColor),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.confirmation_number_outlined,
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            doc["engineNumber"],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColors.whiteFontColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.date_range,
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                    date.toString().split(" ")[0],
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: AppColors.whiteFontColor),
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                  )),
                                            ],
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: (){
                              firebaseCone.vehiclesRef.doc(doc.id).update({
                                "assigned":false
                              });
                              firebaseCone.driverRef.doc(widget.doc.id).update({
                                "assignedV":""
                              });
                              Navigator.pop(context);
                            }, child: const Text("remove vehicle"))
                          ],
                        ))
                      ],
                    ),
                  ),
                );

              }
              return const Text("error no data found");
            },),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Container(
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
                            "All Driver Tasks",
                            style: TextStyle(fontSize: 17),
                          ),
                          if(MediaQuery
                              .of(context)
                              .size
                              .width <= 550)
                            IconButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      AddUserLess(widget.doc)));
                            }, icon: const Icon(Icons.edit))
                        ],
                      ),
                      const Divider(),

                      Container(
                        // width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.whiteFontColor
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search,
                                color: AppColors.blackFontColor,),
                              hintText: "Search By Purpose"
                          ),
                          onChanged: (v) {
                            setState(() {
                              Search = v.toString();
                            });
                          },
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: firebaseCone
                              .serviceRef.where("puropuseOfService",
                              isGreaterThanOrEqualTo: Search).where(
                              "assignedDriver", isEqualTo: widget.doc.id)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot>
                              snapshot) {
                            if (snapshot.hasError) {
                              return const Text(
                                "Error ",
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


                            int numOfData = 20;
                            int numOfPages = (data.length / numOfData)
                                .ceil();
                            return Column(
                              children: [
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: data.length -
                                      (selectedPage * 20) >= 0 ? 20 : data
                                      .length % 20,
                                  physics:
                                  const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    int i = (selectedPage - 1) * 20 +
                                        index;
                                    // print(data[i]['phoneNumber']);
                                    return dispatcherRequestCard(
                                        doc: data[i]);
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
                                    backgroundColor: MaterialStateProperty
                                        .all(Colors.black54),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(38),
                                      ),
                                    ),
                                  ),
                                  inactiveBtnStyle: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius
                                              .circular(38),
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
                          }
                      )
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

class assignDriverDropDown extends StatefulWidget {
  final ValueChanged<String> onChang;
  String select;
  List data;
   assignDriverDropDown(this.select,this.data,{required this.onChang, Key? key})
      : super(key: key);

  @override
  State<assignDriverDropDown> createState() => _assignDriverDropDownState();
}

class _assignDriverDropDownState extends State<assignDriverDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: widget.select,
        items: widget.data.map((e) {
          return DropdownMenuItem(
              value: e.id,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("vehicle Model: "),
                      Text(e['vechileModel']),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Plate number"),
                      Text(e['plateNumber'])
                    ],
                  )
                ],
              ));
        }).toList(),
        onChanged: (v) {
          setState(() {
            widget.onChang.call(v.toString());
            widget.select=v.toString();
          });
        },
      isExpanded: false,
    );
  }
}


class AddUserLess extends StatefulWidget {
  QueryDocumentSnapshot doc;

  AddUserLess(this.doc, {Key? key}) : super(key: key);

  @override
  State<AddUserLess> createState() => _AddUserLessState();
}

class _AddUserLessState extends State<AddUserLess> {

  @override
  Widget build(BuildContext context) {
    if (MediaQuery
        .of(context)
        .size
        .width > 560) {
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          AddUser(widget.doc)
        ],
      ),
    );
  }

}


class AddUser extends StatefulWidget {
  QueryDocumentSnapshot doc;

  AddUser(this.doc, {Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final userPasswordFiledControler = TextEditingController();
  final userEmailFiledControler = TextEditingController();
  final userFirstNameFiledControler = TextEditingController();
  final userLastNameFiledControler = TextEditingController();
  final userDepartmentFiledControler = TextEditingController();
  final userPhoneNumberFiledControler = TextEditingController();
  final userUserAddressFiledControler = TextEditingController();
  final licenceNumberFiledControler = TextEditingController();
  bool userShowPassword = false;
  IconData userPasswordIcon = Icons.visibility_outlined;
  String fNameError = "";
  String lNameError = "";
  String emailError = "";
  String phoneError = "";
  String addressError = "";
  String passwordError = "";
  String licenceNumber = "";

  @override
  void initState() {
    userEmailFiledControler.text = widget.doc['email'];
    userFirstNameFiledControler.text = widget.doc['firstName'];
    userLastNameFiledControler.text = widget.doc['lastName'];
    userPhoneNumberFiledControler.text = widget.doc['phoneNumber'];
    userUserAddressFiledControler.text = widget.doc['currentAddress'];
    licenceNumberFiledControler.text = widget.doc['licenceNumber'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Edite Driver Info",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          const Divider(),

          const SizedBox(height: 20,),
          const Text("First Name", style: TextStyle(fontSize: 15,
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.w700),),
          const SizedBox(height: 10,),
          Container(
            // width: width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteFontColor
            ),
            child: TextFormField(
              controller: userFirstNameFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.account_box_sharp),
                  hintText: "First Name"
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fNameError, style: const TextStyle(color: Colors.red, fontSize: 10),)
            ],
          ),
          const SizedBox(height: 10,),
          const Text("Last Name", style: TextStyle(fontSize: 15,
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.w700),),
          const SizedBox(height: 10,),
          Container(
            // width: width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteFontColor
            ),
            child: TextFormField(
              controller: userLastNameFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.account_box_sharp),
                  hintText: "Last Name"
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lNameError, style: const TextStyle(color: Colors.red, fontSize: 10),)
            ],
          ),
          const SizedBox(height: 10,),

          const Text("Email", style: TextStyle(fontSize: 15,
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.w700),),
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
              Text(
                emailError, style: const TextStyle(color: Colors.red, fontSize: 10),)
            ],
          ), const SizedBox(height: 10,),

          const Text("Licence Number", style: TextStyle(fontSize: 15,
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.w700),),
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
              controller: licenceNumberFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.numbers),
                  hintText: "Licence Number"
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(licenceNumber,
                style: const TextStyle(color: Colors.red, fontSize: 10),)
            ],
          ), const SizedBox(height: 10,),
          const Text("Phone Number", style: TextStyle(fontSize: 15,
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.w700),),
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
              controller: userPhoneNumberFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone Number"
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                phoneError, style: const TextStyle(color: Colors.red, fontSize: 10),)
            ],
          ), const SizedBox(height: 10,),
          const Text("Address", style: TextStyle(fontSize: 15,
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.w700),),
          const SizedBox(height: 10,),
          Container(
            // width: width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteFontColor
            ),
            child: TextFormField(
              controller: userUserAddressFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.add_location),
                  hintText: "Address"
              ),
            ),
          )
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(addressError,
                style: const TextStyle(color: Colors.red, fontSize: 10),)
            ],
          ), const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                  onPressed: () {
                    setState(() {
                      addUserToDb();
                    });
                  },
                  child: const Text("Edit Driver")
              )
            ],
          )
        ],
      ),
    );
  }


  Future<void> addUserToDb() async {
    if (addUserValidation()) {
      firebaseCone.driverRef.doc(widget.doc.id)
          .update({
        "firstName": userFirstNameFiledControler.text,
        "lastName": userLastNameFiledControler.text,
        "currentAddress": userUserAddressFiledControler.text,
        "phoneNumber": userPhoneNumberFiledControler.text,
        "licenceNumber": licenceNumberFiledControler.text,
      })
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
              "Driver Info Edited", style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.green,)
        );
      })
          .catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to Edite Driver Info: $error",
              style: const TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,)
        );
      });
    }
    else {
    }
    if (MediaQuery
        .of(context)
        .size
        .width <= 500) {
      Navigator.pop(context);
    }
  }


  bool addUserValidation() {
    bool valid = true;

    if (userFirstNameFiledControler.text.trim() == "" ||
        userFirstNameFiledControler.text.length < 3) {
      setState(() {
        fNameError = "invalid input";
      });
      valid = false;
    } else {
      setState(() {
        fNameError = "";
      });
    }
    if (userLastNameFiledControler.text.trim() == "" ||
        userLastNameFiledControler.text.length < 3) {
      setState(() {
        lNameError = "invalid input";
      });
      valid = false;
    } else {
      setState(() {
        lNameError = "";
      });
    }
    if (!EmailValidator.validate(userEmailFiledControler.text.trim())) {
      setState(() {
        emailError = "invalid input";
      });
      valid = false;
    } else {
      setState(() {
        emailError = "";
      });
    }
    if (userUserAddressFiledControler.text.trim() == "") {
      setState(() {
        addressError = "invalid user";
      });
      valid = false;
    } else {
      setState(() {
        addressError = "";
      });
    }
    if (licenceNumberFiledControler.text.trim() == "") {
      setState(() {
        licenceNumber = "invalid user";
      });
      valid = false;
    } else {
      setState(() {
        licenceNumber = "";
      });
    }
    if (userPhoneNumberFiledControler.text.trim() == "") {
      setState(() {
        phoneError = "invalid input";
      });
      valid = false;
    } else {
      setState(() {
        phoneError = "";
      });
    }
    return valid;
  }

}