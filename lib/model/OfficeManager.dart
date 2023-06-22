import 'package:bit_vehicle_web/firbaseCon.dart';

class OfficeManager {
  final String id;
  final String firstName;
  final String lastName;
  final String currentAddress;
  final String email;
  final String phoneNumber;
  final String officeNumber;

  OfficeManager(
      {required this.firstName,
      required this.lastName,
      required this.currentAddress,
      required this.email,
      required this.phoneNumber,
      required this.officeNumber,
      required this.id});

  static login(String id) async {
    var istrue;
    final  db=firebaseCone.officeManagerRef.doc(id);
    await db.get().then((value) {
      istrue= value.data();
    });
    return istrue;
  }

  getRequest() {}

  approve() {}

  disApprove() {}

  checkRequest() {}
}
