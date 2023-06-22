// ignore_for_file: file_names, camel_case_types

import 'package:bit_vehicle_web/compnent/officeManager/officeRequestCard.dart';
import 'package:bit_vehicle_web/firbaseCon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../AppColors.dart';

class officeManagerHomePage extends StatefulWidget {
  const officeManagerHomePage({Key? key}) : super(key: key);

  @override
  State<officeManagerHomePage> createState() => _officeManagerHomePageState();
}

class _officeManagerHomePageState extends State<officeManagerHomePage> {
  var department = "";
  var Search="";

  var selectedPage = 1;

  @override
  void initState() {
    firebaseCone.officeManagerRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      // print("object");
      department = value.data()!["department"];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      const Text(
                        "Requests",
                        style: TextStyle(
                            fontSize: 45, color: AppColors.blackFontColor),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              // width: MediaQuery.of(context).size.width,
                              // height: 150,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.witheColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "All Requests",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const Divider(),

                                  Container(
                                    // width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColors.whiteFontColor
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.search,color: AppColors.blackFontColor,),
                                          hintText: "Search"
                                      ),
                                      onChanged: (v){
                                        setState(() {
                                          Search=v.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: firebaseCone.serviceRef
                                          .where("department",
                                              isEqualTo: department)
                                          .where("requestedBody",isGreaterThanOrEqualTo: Search)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {

                                          print(snapshot.error);
                                          return const Text(
                                            "Error",
                                            style:
                                                TextStyle(color: Colors.red),
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (!snapshot.hasData) {
                                          return const Text(
                                            "no data ",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          );
                                        }
                                        final data = snapshot.data!.docs;
                                        // print(data[0]);

                                        int numOfData = 10;
                                        int numOfPages =
                                            (data.length / numOfData).ceil();

                                        return Column(
                                          children: [
                                            ListView.builder(
                                              scrollDirection:
                                                  Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: data.length -
                                                          (selectedPage *
                                                              10) >=
                                                      0
                                                  ? 10
                                                  : data.length % 10,
                                              itemBuilder:
                                                  (context, index) {
                                                int i = (selectedPage - 1) *
                                                        10 +
                                                    index;
                                                return officeRequestCard(
                                                  doc: data[i],
                                                );
                                              },
                                            ),
                                            Pagination(
                                              numOfPages: numOfPages,
                                              selectedPage: selectedPage,
                                              pagesVisible: 5,
                                              onPageChanged: (page) {
                                                setState(() {
                                                  selectedPage = page;
                                                });
                                              },
                                              nextIcon: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                                size: 14,
                                              ),
                                              previousIcon: const Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.black,
                                                size: 14,
                                              ),
                                              activeTextStyle:
                                                  const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              activeBtnStyle: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .all(
                                                            Colors.black54),
                                                shape: MaterialStateProperty
                                                    .all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(38),
                                                  ),
                                                ),
                                              ),
                                              inactiveBtnStyle: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all(
                                                        RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          38),
                                                )),
                                              ),
                                              inactiveTextStyle:
                                                  const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                            )
                                          ],
                                        );
                                      })
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
