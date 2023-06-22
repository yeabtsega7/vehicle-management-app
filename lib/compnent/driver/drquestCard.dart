// ignore_for_file: camel_case_types, file_names

import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class drequestCard extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  const drequestCard({Key? key, required this.doc}) : super(key: key);

  @override
  State<drequestCard> createState() => _drequestCardState();
}

class _drequestCardState extends State<drequestCard> {

  String valueText="";
  final _textFieldController=TextEditingController();
  Future<void> _displayReportDetailInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('input additional detail'),
            content: TextField(
              maxLines: 5,
              minLines: 3,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "detail"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: const Text('cancel'),
                onPressed: () {
                  setState(() {
                    valueText="";
                    _textFieldController.clear();

                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  firebaseCone.serviceRef.doc(widget.doc.id).update({
                    "reported":true,
                    "reportDetails":_textFieldController.text,
                  });
                  firebaseCone.driverRef.doc(widget.doc['assignedDriver']).update(
                      {"onTrip":false}).onError((error, stackTrace)  {
                  });
                  setState(()  {

                    valueText="";
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {

    DateTime date = (widget.doc["endDate"]).toDate();
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
                                widget.doc ["puropuseOfService"],
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
                                widget.doc["requestedBody"],
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
                                widget.doc["distnation"],
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
                                  widget.doc["numberOfPassanger"],
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
                                  widget.doc["department"],
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
                                    widget.doc["officeManagerName"],
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: widget.doc["officeApproved"]
                                ? const Icon(
                              Icons.done_all,
                              color: Colors.green,
                            )
                                : widget.doc["officeDis"]
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
                                    widget.doc["fleetManagerName"],
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: widget.doc["fleetApproved"]
                                ? const Icon(
                              Icons.done_all,
                              color: Colors.green,
                            )
                                : widget.doc["fleetDis"]
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
                                    widget.doc["assignedDriverName"],
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: widget.doc["reported"]?
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          widget.doc["reportDetails"],
                                        overflow: TextOverflow.fade,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ],
                                ),
                                    const SizedBox(height: 5,),
                                    const Text("reported",style: TextStyle(color: Colors.green),)
                              ],
                            ): TextButton(onPressed: (){
                              _displayReportDetailInputDialog(context);
                            }, child: const Text("report")),
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
    );
  }
}
            // widget.doc["reported"]?
