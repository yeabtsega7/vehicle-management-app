// ignore_for_file: camel_case_types

import 'package:bit_vehicle_web/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class userRequestCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const userRequestCard({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = (doc["endDate"]).toDate();
    return Container(
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
                                  : const Text("wetting"),
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
                          child: doc["fleetApproved"]
                              ? const Icon(
                            Icons.done_all,
                            color: Colors.green,
                          )
                              : doc["fleetDis"]
                              ? const Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                          )
                              : const Text("wetting"),
                        )
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
                          child: doc["assignedDriver"].toString()==""?const Text("wetting"):const Text("Assigned"),
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
    );
  }
}
