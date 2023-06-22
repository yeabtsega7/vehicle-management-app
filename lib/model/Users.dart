import 'package:bit_vehicle_web/firbaseCon.dart';

class Users {
  final String id;
  final String firstName;
  final String lastName;
  final String currentAddress;
  final String email;
  final String phoneNumber;

  Users(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.currentAddress,
      required this.email,
      required this.phoneNumber});

  static login(String id,context) async {
    var istrue;
    final  db=firebaseCone.usersRef.doc(id);
    await db.get().then((value) {
      print("user print ${value.data()?["active"]}");
      if(value.data()?["active"]==true){
        istrue= value.data();
      }
     else{

      }
    });
    return istrue;
  }

  sendServiceRequest() {}

  getAppruval() {}

  getService() {}

  Users.fromJson(Map<String, Object?> json):this(
      id:json['id']! as String,
      firstName:json['firstName']! as String,
      lastName:json['lastName']! as String,
      currentAddress:json['currentAddress']! as String,
      email:json['email']! as String,
      phoneNumber:json['phoneNumber']! as String,
  );
  Map<String,Object>toJson(){
    return {
      "id":id,
      "firstName":firstName,
      "lastName":lastName,
      "currentAddress":currentAddress,
      "email":email,
      "phoneNumber":phoneNumber,
    };
  }
}
