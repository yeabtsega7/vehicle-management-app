import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:bit_vehicle_web/model/department.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../AppColors.dart';
import '../userCard.dart';

class dispatcherUserPage extends StatefulWidget {
  const dispatcherUserPage({Key? key}) : super(key: key);

  @override
  State<dispatcherUserPage> createState() => _dispatcherUserPageState();
}

class _dispatcherUserPageState extends State<dispatcherUserPage> {



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
                  child: AddUser(),
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
  String? usersOrderedBy = "firstName";
  List usersOrderedByList = [
    "firstName",
  ];
  String Search="";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Users",
            style: TextStyle(
                fontSize: 30, color: AppColors.blackFontColor),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
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
                              "All Users",
                              style: TextStyle(fontSize: 17),
                            ),
                            if(MediaQuery.of(context).size.width<=550)
                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddUserLess()));
                              }, icon: const Icon(Icons.add))
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
                                prefixIcon: Icon(Icons.search,color: AppColors.blackFontColor,),
                                hintText: "Search By email"
                            ),
                            onChanged: (v){
                              setState(() {
                                Search=v.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: firebaseCone
                                  .usersRef.where("email",isGreaterThanOrEqualTo: Search )
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
                                    Container(
                                      child:ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: data.length-(selectedPage*20)>=0?20:data.length%20,
                                        physics:
                                        const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          int i=(selectedPage-1)*20+index;
                                          print("user data");
                                          print(data[i]['phoneNumber']);
                                          return userCard(doc: data[i]);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Pagination(
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
                                      ),
                                    )
                                  ],
                                );
                              }
                              ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

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
  bool userShowPassword = false;
  IconData userPasswordIcon = Icons.visibility_outlined;
  String fNameError="";
  String lNameError="";
  String emailError="";
  String phoneError="";
  String addressError="";
  String passwordError="";
  String deparment=department.departmentList[0];

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
                "Add New User",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          const Divider(),

          const SizedBox(height: 20,),
          const Text("First Name",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
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
              Text(fNameError,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),
          const SizedBox(height: 10,),
          const Text("Last Name",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
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
              Text(lNameError,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),
          const SizedBox(height: 10,),

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
          const Text("Phone Number",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
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
              Text(phoneError,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),const SizedBox(height: 10,),
          const Text("Address",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
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
              Text(addressError,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),const SizedBox(height: 10,),
          const SizedBox(height: 10,),
          Container(
            // width: width,
            height: 66,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteFontColor
            ),
            child: driverAssignDropDownManu(onValueChange: (String value) {
              deparment=value;
            },),
          ),const SizedBox(height: 10,),
          const Text("Password",style: TextStyle(fontSize: 15,color: AppColors.lightFontColor,fontWeight: FontWeight.w700),),
          const SizedBox(height: 10,),
          Container(
            // width: width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteFontColor
            ),
            child: TextFormField(
              controller: userPasswordFiledControler,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password"
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(passwordError,style: const TextStyle(color: Colors.red,fontSize: 10),)
            ],
          ),

          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                  onPressed: (){
                    setState(() {
                      addUserToDb();
                    });
                  },
                  child: const Text("Add User")
              )
            ],
          )
        ],
      ),
    );
  }


  Future<void> addUserToDb() async {

    if(addUserValidation()){
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmailFiledControler.text.trim(),
          password: userPasswordFiledControler.text,
        ).then((value)
        {
          print(value.user!.uid);
          firebaseCone.usersRef.doc(value.user!.uid)
              .set({
            "id":value.user!.uid,
            "firstName":userFirstNameFiledControler.text,
            "lastName":userLastNameFiledControler.text,
            "currentAddress":userUserAddressFiledControler.text,
            "email":userEmailFiledControler.text.trim(),
            "phoneNumber":userPhoneNumberFiledControler.text,
            "department":deparment,
            "active":true
          })
              .then((value){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text( "User Added",style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.green,)
                );

                FirebaseAuth.instance.signOut();
          })
              .catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text( "Failed to add user: $error",style: const TextStyle(color: Colors.white),),
                      backgroundColor: Colors.red,)
                );
          });
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text( "The password provided is too weak.",style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.red,)
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text( "The account already exists for that email.",style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.red,)
          );
        }
      } catch (e) {
        print(e);
      }
      print("add");
    }
    else{
      print("fail");
    }
    userPasswordFiledControler.clear();
    userEmailFiledControler.clear();
    userFirstNameFiledControler.clear();
    userLastNameFiledControler.clear();
    userDepartmentFiledControler.clear();
    userPhoneNumberFiledControler.clear();
    userUserAddressFiledControler.clear();
    if(MediaQuery.of(context).size.width<=500){
      Navigator.pop(context);
    }
  }


  bool addUserValidation(){
    bool valid =true;
    if(userFirstNameFiledControler.text.trim()==""||userFirstNameFiledControler.text.length<3){
      setState(() {
        fNameError="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        fNameError="";
      });
    }
    if(userLastNameFiledControler.text.trim()==""||userLastNameFiledControler.text.length<3){
      setState(() {
        lNameError="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        lNameError="";
      });
    }
    if(!EmailValidator.validate(userEmailFiledControler.text.trim())){
      setState(() {
        emailError="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        emailError="";
      });
    }
    if(userUserAddressFiledControler.text.trim()==""){
      setState(() {
        addressError="invalid user";
      });
      valid=false;
    }else{
      setState(() {
        addressError="";
      });
    }
    if(userPasswordFiledControler.text==""||userPasswordFiledControler.text.length<6){
      setState(() {
        passwordError="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        passwordError="";
      });
    }
    if(userPhoneNumberFiledControler.text.trim()==""){
      setState(() {
        phoneError="invalid input";
      });
      valid=false;
    }else{
      setState(() {
        phoneError="";
      });
    }
    return valid;
  }

}


class AddUserLess extends StatefulWidget {
  const AddUserLess({Key? key}) : super(key: key);

  @override
  State<AddUserLess> createState() => _AddUserLessState();
}

class _AddUserLessState extends State<AddUserLess> {

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width>560){
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: const [
          AddUser()
        ],
      ),
    );
  }
}


class driverAssignDropDownManu extends StatefulWidget {
  final ValueChanged<String> onValueChange;

  const driverAssignDropDownManu({
    Key? key,
    required this.onValueChange,
  }) : super(key: key);

  @override
  State<driverAssignDropDownManu> createState() =>
      _driverAssignDropDownManuState();
}

class _driverAssignDropDownManuState extends State<driverAssignDropDownManu> {
  List driverList = department.departmentList;

    var selectedDriver;
 @override
  void initState() {
   selectedDriver=driverList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Department: "),
                Expanded(
                    child: Text(
                      selectedDriver,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: DropdownButton(
                isExpanded: true,
                  value: selectedDriver,
                  items: driverList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (Object? value) {
                    setState(() {
                      print("selected value");
                      print(value);
                      selectedDriver = value!.toString();
                      widget.onValueChange.call(selectedDriver);
                    });
                  }),
            )
          ],
        ),
      );
  }
}