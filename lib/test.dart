import 'package:flutter/material.dart';

import 'AppColors.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                Container(
                  height: 200,
                  color: AppColors.darkBckColor,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.label),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "purpose of service",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_pin),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "requested body",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "addis ababa",
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
                                  Icon(Icons.date_range),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "date",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.numbers),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "number",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.account_balance),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "Computer engineering",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                            ],
                          )),
                        ],
                      ),
                      Padding(
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
                                        Text("office Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of ofice manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("weating"),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("fleet Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of fleet manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("weating"),
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
                                        Text("Assaigned Driver:"),
                                        Expanded(
                                            child: Text(
                                          "name of driver",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("weating"),
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
                Container(
                  height: 200,
                  color: Colors.green,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.label),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "purpose of service",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_pin),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "requested body",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "addis ababa",
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
                                  Icon(Icons.date_range),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "date",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.numbers),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "number",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.account_balance),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "Computer engineering",
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
                                    const Row(
                                      children: [
                                        Text("office Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of ofice manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text("Approve")),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "Disapprove",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("fleet Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of fleet manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("weating"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Assaigned Driver:"),
                                        Expanded(
                                            child: Text(
                                          "name of driver",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("weating"),
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
                Container(
                  height: 200,
                  color: Colors.yellow,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.label),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "purpose of service",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_pin),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "requested body",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "addis ababa",
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
                                  Icon(Icons.date_range),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "date",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.numbers),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "number",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.account_balance),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "Computer engineering",
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
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("office Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of ofice manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.done_all,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text("fleet Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of fleet manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text("Approve")),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "Disapprove",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Assaigned Driver:"),
                                        Expanded(
                                            child: Text(
                                          "name of driver",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("weating"),
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
                Container(
                  height: 200,
                  color: Colors.grey,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.label),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "purpose of service",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_pin),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "requested body",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "addis ababa",
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
                                  Icon(Icons.date_range),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "date",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.numbers),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "number",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.account_balance),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "Computer engineering",
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
                          const Expanded(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("office Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of ofice manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.done_all,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("fleet Manage:"),
                                        Expanded(
                                            child: Text(
                                          "name of fleet manager",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.done_all,
                                          color: Colors.green,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                driverAssignDropDownManu(
                                  onValueChange: (value){

                                  },
                                ),
                                TextButton(onPressed: (){}, child: const Text("Assign",style: TextStyle(fontSize:20,color:Colors.green),))
                              ],
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.grey,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.label),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                          "purpose of service",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_pin),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                          "requested body",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                          "addis ababa",
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
                                      Icon(Icons.date_range),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: Text(
                                            "date",
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.numbers),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: Text(
                                            "number",
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.account_balance),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: Text(
                                            "Computer engineering",
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                          ))
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Padding(
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
                                        Text("office Manage:"),
                                        Expanded(
                                            child: Text(
                                              "name of ofice manager",
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.done_all,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("fleet Manage:"),
                                        Expanded(
                                            child: Text(
                                              "name of fleet manager",
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.done_all,
                                          color: Colors.green,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Icon(Icons.done_all)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 560)
            Expanded(
                child: Container(
              color: Colors.green,
            ))
        ],
      ),
    ));
  }
}

class driverAssignDropDownManu extends StatefulWidget {
  final ValueChanged<String> onValueChange;

  const driverAssignDropDownManu({
    Key? key,
    required this.onValueChange,
  }) : super(key: key);

  @override
  State<driverAssignDropDownManu> createState() =>
      _driverAssignDropDownManuState();
}

class _driverAssignDropDownManuState extends State<driverAssignDropDownManu> {
  List driverList = [
    "name6",
    "name5",
    "name4",
    "name3",
    "name2",
    "name1",
  ];
  var selectedDriver = "name6";

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(selectedDriver),
              const Expanded(
                  child: Text(
                    "name of driver",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButton(
              value: selectedDriver,
                items: driverList.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (Object? value) {
                  setState(() {
                    print("selected value");
                    print(value);
                    selectedDriver = value!.toString();
                  });
                }),
          )
        ],
      );
  }
}
