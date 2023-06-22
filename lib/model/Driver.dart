
import 'package:bit_vehicle_web/firbaseCon.dart';

class Driver {
  final String id;
  final String firstName;
  final String lastName;
  final String licenceNumber;
  final String currentAddress;
  final String email;
  final String phoneNumber;

  Driver(
      {required this.id,
      required this.lastName,
      required this.firstName,
      required this.licenceNumber,
      required this.currentAddress,
      required this.email,
      required this.phoneNumber});

  static login(String id) async {
    var istrue;
    final  db=firebaseCone.driverRef.doc(id);
    await db.get().then((value) {
      istrue= value.data();
    });
    return istrue;
  }

  driverVechile() {}

  generateReport() {}

  reciveRequest() {}
}
