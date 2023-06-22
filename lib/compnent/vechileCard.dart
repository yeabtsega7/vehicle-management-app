import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

class vechileCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const vechileCard({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timestamp d = doc["manufacturingDate"];
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(d.millisecondsSinceEpoch);
    return Container(
      height: 65,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: AppColors.darkBckColor,
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
              flex: 4,
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
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    if (await confirm(
                      context,
                      title: const Text('Delet user'),
                      content: const Text('Would you like to remove?'),
                      textOK: const Text('Yes'),
                      textCancel: const Text('No'),
                    )) {
                      firebaseCone.driverRef
                          .where("assignedV", isEqualTo: doc.id)
                          .get()
                          .then((value) {
                        if(value.docs.isEmpty){

                        }else if(!doc['assigned']){

                        }else{
                          firebaseCone.driverRef.doc(value.docs[0].id).update({
                            "assignedV": "",
                            "onTrip": false,
                          });
                        }

                        firebaseCone.vehiclesRef.doc(doc.id).delete();
                      });
                    } else {}
                  },
                  icon: const Icon(Icons.delete_forever),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
