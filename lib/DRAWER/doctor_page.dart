import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportclone/DRAWER/add_doctor_page.dart';
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
  var selectIndex;

  @override
  void initState() {
    Provider.of<CommonFunction>(context, listen: false)
        .getAssisDocs(id: "8072031619");
    super.initState();
  }

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
          child: Provider.of<CommonFunction>(context, listen: true)
                      .doctorsList ==
                  null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(30),
                  itemCount: Provider.of<CommonFunction>(context, listen: true)
                          .doctorsList
                          .length +
                      1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex = index;
                            });
                            if (selectIndex ==
                                Provider.of<CommonFunction>(context,
                                        listen: false)
                                    .doctorsList
                                    .length) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddDoctor()));
                            }
                          },
                          child: Container(
                            height: h * 0.12,
                            width: w * 0.25,
                            decoration: BoxDecoration(
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                borderRadius: BorderRadius.circular(2)),
                            child: index ==
                                    Provider.of<CommonFunction>(context,
                                            listen: true)
                                        .doctorsList
                                        .length
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
                                          "${Provider.of<CommonFunction>(context, listen: true).doctorsList[index]["drFname"].toString().substring(0, 1)}",
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          height: h * 0.03,
                          width: w * 0.25,
                          child: Center(
                            child: CommonText(
                              textColor: Colors.blueGrey,
                              text: index ==
                                      Provider.of<CommonFunction>(context,
                                              listen: true)
                                          .doctorsList
                                          .length
                                  ? "ADD Doctors"
                                  : "${Provider.of<CommonFunction>(context, listen: true).doctorsList[index]["drFname"]}",
                            ),
                          ),
                        )
                      ],
                    );
                  })),
    );
  }
}
