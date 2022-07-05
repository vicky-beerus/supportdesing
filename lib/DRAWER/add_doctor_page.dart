import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:supportclone/DRAWER/otp_page.dart';
import 'package:supportclone/Modal/modal_datas.dart';
import 'package:supportclone/common_widgets/common_text.dart';
import 'package:supportclone/common_widgets/common_textformfield.dart';
import 'package:supportclone/service/common_function.dart';

import '../common_widgets/common_appbar.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  TextEditingController doctorSearchController = TextEditingController();
  var generateOtp;
  var docFname, docLname, docId;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 0.08),
          child: CommonAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            text: "Doctors page",
          ),
        ),
        body: Container(
          height: h,
          width: w,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              CommonTextFormField(
                height: h * 0.08,
                width: w * 0.9,
                onSave: (val) {
                  if (val!.length < 10) {
                    final snackbar = SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      content: CommonText(
                        text: "phone number is less then 10 deigit",
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.blueGrey,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } else if (val!.length > 10) {
                    final snackbar = SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      content: CommonText(
                        text: "phone number is grader then 10 deigit",
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.blueGrey,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } else {
                    Provider.of<CommonFunction>(context, listen: false)
                        .searchChangingStream(
                            stream: Provider.of<CommonFunction>(context,
                                    listen: false)
                                .doctorsSearchStream(
                                    givenText: val.toString()));
                  }
                },
                onChange: (value) {
                  setState(() {
                    print(value);
                    // Provider.of<CommonFunction>(context, listen: false)
                    //     .searchChangingStream(
                    //         stream: Provider.of<CommonFunction>(context,
                    //                 listen: false)
                    //             .doctorsSearchStream(
                    //                 givenText: value.toString()));
                    print('zzzzzzzzzzz');
                  });
                },
                controller: doctorSearchController,
                hintText: "Search",
                suffixWidget: Icon(
                  Icons.search,
                  color: Colors.blueGrey,
                ),
              ),
              StreamBuilder<List<DoctorModal>>(
                  stream: Provider.of<CommonFunction>(context, listen: false)
                      .searchDoctor,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      setState(() {});
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: h * 0.1,
                                    width: w * 0.9,
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: h * 0.08,
                                        width: w * 0.15,
                                        margin: EdgeInsets.only(left: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: CommonText(
                                            text:
                                                "${snapshot.data![index].doc_firstName.toString().substring(0, 1)}",
                                            textSize: 25,
                                            textColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: h * 0.02,
                                  left: w * 0.2,
                                  child: CommonText(
                                    textSize: 15,
                                    text:
                                        "Doctor: ${snapshot.data![index].doc_firstName}",
                                  ),
                                ),
                                Positioned(
                                  bottom: h * 0.02,
                                  left: w * 0.2,
                                  child: CommonText(
                                    textSize: 15,
                                    text: "${snapshot.data![index].phone}",
                                  ),
                                ),
                                Positioned(
                                  top: h * 0.002,
                                  right: w * 0.01,
                                  child: Checkbox(
                                      value: snapshot.data![index].doc_status,
                                      activeColor: Colors.blueGrey,
                                      onChanged: (val) {
                                        setState(() {
                                          snapshot.data![index].doc_status =
                                              val;
                                        });
                                      }),
                                ),
                                Positioned(
                                    bottom: h * 0.02,
                                    right: w * 0.05,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (snapshot
                                                  .data![index].doc_status ==
                                              true) {
                                            generateOtp =
                                                Random().nextInt(200000);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtpPage(
                                                          currentOtp:
                                                              generateOtp,
                                                          docFname: snapshot
                                                              .data![index]
                                                              .doc_firstName,
                                                          docId: snapshot
                                                              .data![index]
                                                              .doc_id,
                                                          docLname: snapshot
                                                              .data![index]
                                                              .doc_lastName,
                                                        )));
                                          }
                                          print(generateOtp);
                                        });
                                      },
                                      child: Container(
                                        height: h * 0.03,
                                        width: w * 0.25,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Center(
                                          child: CommonText(
                                            textColor: Colors.blueGrey,
                                            text: "Send otp doctor",
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            );
                          });
                    } else if (snapshot.data == null) {
                      return Column(
                        children: [
                          SizedBox(
                            height: h * 0.25,
                          ),
                          Icon(
                            Icons.search,
                            size: 35,
                          ),
                          Center(
                            child: Container(
                              child: CommonText(
                                text: "Search Your Doctors",
                                textSize: 25,
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          ),
        ),
        bottomSheet: Container(
            height: h * 0.08,
            width: w,
            child: Center(
                child: Container(
              height: h * 0.06,
              width: w * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey),
              child: GlassmorphicContainer(
                padding: EdgeInsets.all(10),
                width: w * 0.89,
                height: h * 0.058,
                borderRadius: 50,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white38.withOpacity(0.2)
                    ],
                    stops: [
                      0.1,
                      1,
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonText(
                        textSize: 14,
                        text: "SEND OTP",
                        textColor: Colors.white,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
                border: 1,
                blur: 15,
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white10, Colors.white24],
                ),
              ),
            ))));
  }

  postOtp({id, fName, lName}) async {
    final posting = FirebaseFirestore.instance.collection('otp').doc(id).set({
      "doc_id": id,
      "doc_firstname": fName,
      "doc_lastname": lName,
      "otp": generateOtp.toString(),
      "phone": id,
    }).whenComplete(() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OtpPage())));
    ;
  }

  postMessage({doc_firstname, doc_lastname, id, message}) {
    final postMesaage =
        FirebaseFirestore.instance.collection('messages').doc(id).set({
      "doc_firstname": doc_firstname,
      "doc_lastname": doc_lastname,
      "id": id,
      "message":
          "Hello, Dr.${doc_firstname}${doc_lastname}, vijay wants to be your assistant there otp: ${generateOtp}, If you want to proceed further",
    });
  }
}
