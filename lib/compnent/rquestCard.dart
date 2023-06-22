// ignore_for_file: camel_case_types, file_names

import 'package:bit_vehicle_web/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class requestCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const requestCard({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = (doc["endDate"]).toDate();
    return InkWell(
      onTap: () {},
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.darkBckColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.label),
                        const SizedBox(width: 10,),
                        Text(
                          doc["puropuseOfService"],
                          style: const TextStyle(
                              fontSize: 20, color: AppColors.whiteFontColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person_pin),
                        const SizedBox(width: 10,),
                        Text(
                          doc["requestedBody"],
                          style: const TextStyle(
                              fontSize: 15, color: AppColors.lightFontColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 10,),
                        Text(
                          doc["distnation"],
                          style: const TextStyle(
                              fontSize: 15, color: AppColors.lightFontColor),
                        )
                      ],
                    )
                  ],
                )),
            Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_sharp),
                        const SizedBox(width: 10,),
                        Text("${date.year}-${date.month}-${date.day}",),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.numbers),
                        const SizedBox(width: 10,),
                        Text(
                          doc["numberOfPassanger"],
                          style: const TextStyle(
                              fontSize: 15, color: AppColors.lightFontColor),
                        )
                      ],
                    )

                  ],
                )),
          ],
        ),
      ),
    );
  }
}
