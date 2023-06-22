// ignore_for_file: camel_case_types

import 'package:bit_vehicle_web/AppColors.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dispatcherRequestCard extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  dispatcherRequestCard({Key? key, required this.doc}) : super(key: key);

  @override
  State<dispatcherRequestCard> createState() => _dispatcherRequestCardState();
}

class _dispatcherRequestCardState extends State<dispatcherRequestCard> {
  late String assigndriverName="";

  Future<void> _AassignDriver(BuildContext context) async {
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
                  if(assigndriverName==""){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("select driver from drop down first"),
                          backgroundColor: Colors.red,)
                    );
                  }else{
                    String name="";
                    firebaseCone.driverRef.doc(assigndriverName).get().then((value) {
                      name=value['email'];
                      print("driver id $assigndriverName");
                      firebaseCone.serviceRef.doc(widget.doc.id).update({
                        "assignedDriver": assigndriverName,
                        "assignedDriverName":name
                      });
                    });
                      print("driver name $name");

                    firebaseCone.driverRef.doc(assigndriverName).update({
                      "onTrip":true
                    });
                    print("assigndriverName $assigndriverName");
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Request Approved"),
                          backgroundColor: Colors.green,)
                    );
                  }
                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = (widget.doc["endDate"]).toDate();
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
                              widget.doc["puropuseOfService"],
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
                          child: widget.doc["fleetDis"]
                              ? const Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                          )
                              : widget.doc["fleetApproved"]
                              ? const Icon(
                            Icons.done_all,
                            color: Colors.green,
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
                        widget.doc["fleetApproved"] ?
                        widget.doc["assignedDriver"].toString() == ""
                            ? Column(
                          children: [
                            StreamBuilder(
                              stream: firebaseCone.driverRef
                                  .where("onTrip",isEqualTo: false)
                                  .where("active",isEqualTo: true)
                                  .where("assignedV",isGreaterThan: "")
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  print("error ${snapshot.error}");
                                  return const Text("error");
                                }
                                if (snapshot.hasData) {
                                  print("vehicle data ${snapshot.data!.docs}");
                                  var data = snapshot.data!.docs;
                                  String select=data.isNotEmpty?data[0]['id']:"no vehicle to assign";
                                  print("vechile ${select}");
                                  return driverAssignDropDownManu(
                                    select,data,
                                    onValueChange: (value) {
                                      assigndriverName = value;
                                    },
                                  );
                                } else {}
                                return const Text("data");
                              },
                            ),

                            TextButton(onPressed: () {
                              _AassignDriver(context);
                            },
                                child: const Text("Assign", style: TextStyle(
                                    fontSize: 20, color: Colors.green),))
                          ],
                        ) : Column(
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
                            widget.doc["reported"] ?
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(widget.doc["reportDetails"],
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,))
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Repoted"),
                                )
                              ],
                            )
                                :
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Assigned"),
                            )
                          ],
                        ) : Column(
                          children: [
                            Row(
                              children: [
                                const Text("Assigned Driver:"),
                                Expanded(
                                    child: Text(
                                      widget.doc["assignedDriver"],
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("weating"),
                            )
                          ],
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


class driverAssignDropDownManu extends StatefulWidget {
  final ValueChanged<String> onValueChange;
  String select;
  List doc;

  driverAssignDropDownManu(
      this.select,
      this.doc,
      {
    Key? key,
    required this.onValueChange,
  }) : super(key: key);

  @override
  State<driverAssignDropDownManu> createState() =>
      _driverAssignDropDownManuState();
}

class _driverAssignDropDownManuState extends State<driverAssignDropDownManu> {


  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text("Assigned Driver: "),
              Expanded(
                  child: Text(
                    "selectedDriver",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButton(
                value: widget.select,
                items: widget.doc.map((e) {
                  return DropdownMenuItem(
                    value: e['id'],
                    child: Text(e['email']),
                  );
                }).toList(),
                onChanged: (Object? value) {
                  setState(() {
                    widget.select = value!.toString();
                    widget.onValueChange.call(value.toString());
                  });
                }),
          )
        ],
      );
  }
}
