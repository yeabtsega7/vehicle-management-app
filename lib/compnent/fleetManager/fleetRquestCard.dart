// ignore_for_file: camel_case_types, file_names, use_build_context_synchronously

import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class fleetRequestCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const fleetRequestCard({Key? key, required this.doc}) : super(key: key);


  Future<void> _approve(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Approve Request'),
            content: const Text('are you sure you want to the Approve Request'),
            actions: <Widget>[
              MaterialButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Yes'),
                onPressed: () async {
                  await firebaseCone.serviceRef.doc(doc.id).update({
                    "fleetApproved": true,
                    "fleetDis": false,
                    "fleetManagerName": FirebaseAuth.instance.currentUser!.email
                  }).then((value) async {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Request Approved"),
                          backgroundColor: Colors.green,)
                    );
                  });
                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }

  Future<void> _disapprove(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Disapprove Request'),
            content: const Text('are you sure you want to the Disapprove Request'),
            actions: <Widget>[
              MaterialButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Yes'),
                onPressed: () async {
                  await firebaseCone.serviceRef.doc(doc.id).update({
                    "fleetApproved": false,
                    "fleetDis": true,
                    "fleetManagerName": FirebaseAuth.instance.currentUser!.email
                  }).then((value) async {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Request Disapproved"),
                          backgroundColor: Colors.green,)
                    );
                  });
                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = (doc["endDate"]).toDate();
    return InkWell(
      onTap: () {},
      child: Container(
        height: 200,
        color: AppColors.darkBckColor,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.label),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                                doc["puropuseOfService"],
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.person_pin),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                                doc["requestedBody"],
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                                doc["distnation"],
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Text(
                                  "${date.year}-${date.month}-${date.day}",
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.numbers),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Text(
                                  doc["numberOfPassanger"],
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.account_balance),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Text(
                                  doc["department"],
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("office Manage:"),
                              Expanded(
                                  child: Text(
                                    doc["officeManagerName"],
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: doc["officeApproved"]
                                  ? const Icon(
                                Icons.done_all,
                                color: Colors.green,
                              )
                                  : doc["officeDis"]
                                  ? const Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              )
                                  : const Text("wetting")
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("fleet Manage:"),
                              Expanded(
                                  child: Text(
                                    doc["fleetManagerName"],
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: doc["officeApproved"]
                                  ? doc['fleetApproved']
                                  ? const Icon(Icons.done_all, color: Colors.green,)
                                  : doc['fleetDis'] ? const Icon(
                                Icons.close, color: Colors.red,) :
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        _approve(context);
                                      },
                                      child: const Text("Approve")),
                                  TextButton(
                                      onPressed: () {
                                        _disapprove(context);
                                      },
                                      child: const Text(
                                        "Disapprove",
                                        style: TextStyle(
                                            color: Colors.red),
                                      )),
                                ],
                              ):const Text("wating")
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("Assigned Driver:"),
                              Expanded(
                                  child: Text(
                                    doc["assignedDriverName"],
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: doc["assignedDriver"].toString() == ""
                                ? const Text("wetting")
                                : const Text("Assigned"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      // Container(
      //   height: 100,
      //   margin: const EdgeInsets.only(bottom: 10),
      //   padding: const EdgeInsets.all(10),
      //   decoration: BoxDecoration(
      //       color: AppColors.darkBckColor,
      //       borderRadius: BorderRadius.circular(15)),
      //   child: Row(
      //     children: [
      //       Expanded(
      //           flex: 2,
      //           child: Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   const Icon(Icons.label),
      //                   const SizedBox(width: 10,),
      //                   Text(
      //                     doc["puropuseOfService"],
      //                     style: const TextStyle(
      //                         fontSize: 20, color: AppColors.whiteFontColor),
      //                   ),
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   const Icon(Icons.person_pin),
      //                   const SizedBox(width: 10,),
      //                   Text(
      //                     doc["requestedBody"],
      //                     style: const TextStyle(
      //                         fontSize: 15, color: AppColors.lightFontColor),
      //                   ),
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   const Icon(Icons.location_on),
      //                   const SizedBox(width: 10,),
      //                   Text(
      //                     doc["distnation"],
      //                     style: const TextStyle(
      //                         fontSize: 15, color: AppColors.lightFontColor),
      //                   )
      //                 ],
      //               )
      //             ],
      //           )),
      //       Expanded(
      //           child: Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   const Icon(Icons.calendar_month_sharp),
      //                   const SizedBox(width: 10,),
      //                   Text("${date.year}-${date.month}-${date.day}",),
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   const Icon(Icons.numbers),
      //                   const SizedBox(width: 10,),
      //                   Text(
      //                     doc["numberOfPassanger"],
      //                     style: const TextStyle(
      //                         fontSize: 15, color: AppColors.lightFontColor),
      //                   )
      //                 ],
      //               )
      //
      //             ],
      //           )),
      //     ],
      //   ),
      // ),
    );
  }
}
