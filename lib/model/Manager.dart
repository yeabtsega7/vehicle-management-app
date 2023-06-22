import 'package:bit_vehicle_web/firbaseCon.dart';

class FleetManager {
  final String id;
  final String firstName;
  final String lastName;
  final String currentAddress;
  final String email;
  final String phoneNumber;
  final String officeNumber;

  FleetManager(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.currentAddress,
      required this.email,
      required this.phoneNumber,
      required this.officeNumber});

  static login(String id) async {

    var istrue;
    final  db=firebaseCone.fleetManagerRef.doc(id);
    await db.get().then((value) {
      istrue= value.data();
    });
    return istrue;
  }

  getCheckedRequest() {}

  approval() {}

  disapprove() {}

  viewRequest() {}
}
