import 'package:bit_vehicle_web/firbaseCon.dart';

class Dispatcher {
  final String id;
  final String lastName;
  final String firstName;
  final String currentAddress;
  final String email;
  final String phoneNumber;
  final String officeNumber;

  Dispatcher(
      {required this.id,
      required this.lastName,
      required this.firstName,
      required this.currentAddress,
      required this.email,
      required this.phoneNumber,
      required this.officeNumber});

  static login(String id) async {
    var istrue;
    final  db=firebaseCone.dispatcherRef.doc(id);
    await db.get().then((value) {
      print(value);
      istrue= value.data();
    });
    return istrue;
  }
  getServiceRequest() {}

  checkRequest() {}

  sendRequestToManager() {}

  getApproval() {}

  assignVechile() {}

  assignDriver() {}

  trackDriver() {}

  createAccount() {}

  viewVechileStatus() {}
}
