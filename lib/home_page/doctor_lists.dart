import 'package:flutter/material.dart';
import 'package:supportclone/common_widgets/common_text.dart';
import 'package:supportclone/common_widgets/commoncircleavatar.dart';
import 'package:supportclone/home_page/tab_page/open_list.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  List<Map<String, dynamic>> doctorData = [
    {"value": "1", "label": "Hari"},
    {"value": "2", "label": "Perasana"}
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.09,
      width: w,
      color: Colors.blueGrey,
      child: ListView.builder(
          itemCount: doctorData.length,
          padding: EdgeInsets.only(left: w * 0.02),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  FuctionHelp().changeIndex(index: doctorData[index]["value"]);
                },
                child: CommonCircularAvatar(
                  radius: h * 0.05,
                  backgroundColor: Colors.white,
                  content: CommonText(
                    text:
                        "${doctorData[index]["label"].toString().substring(0, 1)}",
                    textSize: 25,
                    textColor: Colors.blueGrey,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class FuctionHelp {
  static String doctorIndex = "0";
  changeIndex({index}) {
    doctorIndex = index;
    print(doctorIndex);
    StreamFuctions().geetingUserData(doctorid: doctorIndex);
  }
}
