// ignore_for_file: file_names, camel_case_types

import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/compnent/dispatcher/userProfile.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

class userCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const userCard({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  userProfile(doc)));
      },
      child: Container(
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
                          doc["firstName"] + " " + doc["lastName"],
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
                            Icons.email_outlined,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              doc["email"],
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
                                Icons.phone,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                doc["phoneNumber"],
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.whiteFontColor),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                doc["currentAddress"],
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
                child: Container(
                    child: doc['active']
                        ? TextButton(
                            onPressed: () async {
                              if (await confirm(
                                context,
                                title: const Text('DeActive user'),
                                content: const Text(
                                    'Would you like to DeActive the user?'),
                                textOK: const Text('Yes'),
                                textCancel: const Text('No'),
                              )) {
                                firebaseCone.usersRef
                                    .doc(doc.id)
                                    .update({"active": false});
                              } else {}
                            },
                            child: const Text(
                              "DeActive",
                              style: TextStyle(color: Colors.green),
                            ))
                        : TextButton(
                            onPressed: () async {
                              if (await confirm(
                                context,
                                title: const Text('DeActive user'),
                                content: const Text(
                                    'Would you like to Active the user?'),
                                textOK: const Text('Yes'),
                                textCancel: const Text('No'),
                              )) {
                                firebaseCone.usersRef
                                    .doc(doc.id)
                                    .update({"active": true});
                              } else {}
                            },
                            child: const Text(
                              "Active",
                              style: TextStyle(color: Colors.red),
                            )))),
          ],
        ),
      ),
    );
  }
}
