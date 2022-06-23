import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              onChange: (value) {
                print(value);
                Provider.of<CommonFunction>(context, listen: false)
                    .searchChangingStream(
                        stream: Provider.of<CommonFunction>(context,
                                listen: false)
                            .doctorsSearchStream(givenText: value.toString()));
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
                                      borderRadius: BorderRadius.circular(10)),
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
                                    value: true,
                                    activeColor: Colors.blueGrey,
                                    onChanged: (val) {}),
                              ),
                              Positioned(
                                  bottom: h * 0.02,
                                  right: w * 0.05,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        generateOtp = Random().nextInt(200000);
                                      });
                                      print(generateOtp);
                                      postOtp(
                                          id: snapshot.data![index].phone,
                                          fName: snapshot
                                              .data![index].doc_firstName,
                                          lName: snapshot
                                              .data![index].doc_lastName);
                                    },
                                    child: Container(
                                      height: h * 0.03,
                                      width: w * 0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: CommonText(
                                          textColor: Colors.blueGrey,
                                          text: "Send otp >",
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  postOtp({id, fName, lName}) async {
    final posting = FirebaseFirestore.instance.collection('otp').doc(id).set({
      "doc_id": id,
      "doc_firstname": fName,
      "doc_lastname": lName,
      "otp": generateOtp.toString(),
      "phone": id,
    });
  }
}
