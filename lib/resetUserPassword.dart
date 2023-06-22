import 'package:bit_vehicle_web/AppColors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class resetUserPassword extends StatefulWidget {
  const resetUserPassword({Key? key}) : super(key: key);

  @override
  State<resetUserPassword> createState() => _resetUserPasswordState();
}

class _resetUserPasswordState extends State<resetUserPassword> {
  final emailFiledControler = TextEditingController();
  final passwordFiledControler = TextEditingController();
  bool showPassword = false;
  IconData icon = Icons.visibility_outlined;
  String errorMassage = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (showPassword) {
      icon = Icons.visibility_off_outlined;
    } else {
      icon = Icons.visibility_outlined;
    }
    return Scaffold(
      backgroundColor: AppColors.witheBackColor,
      body: SizedBox(
        width: width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: height,
                padding: EdgeInsets.symmetric(horizontal: height * 0.09),
                decoration: MediaQuery.of(context).size.width <= 830
                    ? const BoxDecoration(
                        color: AppColors.darkBckColor,
                        image: DecorationImage(
                            alignment: Alignment(-1.0, 0),
                            image: AssetImage('assets/images/vehicle.png')),
                      )
                    : const BoxDecoration(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                            fontSize: 40, color: AppColors.blackFontColor),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.lightFontColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            // width: width,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.whiteFontColor),
                            child: TextFormField(
                              controller: emailFiledControler,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Enter Email"),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                errorMassage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton(
                                  onPressed: () {
                                    resetPassword();
                                  },
                                  child: const Text("reset password"))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (MediaQuery.of(context).size.width > 830)
              Expanded(
                child: Container(
                  height: height,
                  alignment: FractionalOffset.centerLeft,
                  decoration: const BoxDecoration(
                    color: AppColors.darkBckColor,
                    image: DecorationImage(
                        alignment: Alignment(-1.0, 0),
                        image: AssetImage('assets/images/vehicle.png')),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/BitLogo.png'),
                        const SizedBox(
                          height: 50,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "BiT",
                              style: TextStyle(
                                  fontSize: 70, color: AppColors.redFontColor),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Vehicle",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: AppColors.whiteFontColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Management System",
                          style: TextStyle(
                              fontSize: 35, color: AppColors.whiteFontColor),
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future resetPassword() async {
    if (EmailValidator.validate(emailFiledControler.text.trim())) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailFiledControler.text.trim())
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.height) * 0.18),
              backgroundColor: Colors.green,
              content: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("reset password send to your email")],
              )));
        })
            .catchError(
                (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.symmetric(
                          horizontal: (MediaQuery.of(context).size.height) * 0.18),
                      backgroundColor: Colors.red,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [Text(e.toString())],
                      )));
                });
      } on FirebaseAuthException catch (e) {}
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.height) * 0.18),
          backgroundColor: Colors.red,
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Wrong input try agan")],
          )));
    }
  }
}
