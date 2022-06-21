import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supportclone/Modal/modal_datas.dart';
import 'package:supportclone/common_widgets/common_appbar.dart';
import 'package:supportclone/common_widgets/common_text.dart';
import 'package:supportclone/home_page/homepage.dart';
import 'package:supportclone/service/common_function.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          text: "Doctors page",
        ),
      ),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(7),
        child: StreamBuilder<List<DoctorModal>>(
            stream: CommonFunction().streamDoctors(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    padding: EdgeInsets.all(30),
                    itemCount: snapshot.data!.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            height: h * 0.12,
                            width: w * 0.25,
                            decoration: BoxDecoration(
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                borderRadius: BorderRadius.circular(2)),
                            child: index == snapshot.data!.length
                                ? Center(
                                    child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 35,
                                  ))
                                : Center(
                                    child: CommonText(
                                      textColor: Colors.white,
                                      textSize: 35,
                                      text:
                                          "${snapshot.data![index].doc_firstName.toString().substring(0, 1)}",
                                    ),
                                  ),
                          ),
                          Container(
                            height: h * 0.03,
                            width: w * 0.25,
                            child: Center(
                              child: CommonText(
                                textColor: Colors.blueGrey,
                                text: index == snapshot.data!.length
                                    ? "ADD Doctors"
                                    : "${snapshot.data![index].doc_firstName}",
                              ),
                            ),
                          )
                        ],
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
