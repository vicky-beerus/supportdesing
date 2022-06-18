import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportclone/Modal/modal_datas.dart';
import 'package:supportclone/common_widgets/common_text.dart';
import 'package:supportclone/common_widgets/commoncircleavatar.dart';
import 'package:supportclone/home_page/tab_page/open_list.dart';
import 'package:supportclone/service/common_function.dart';

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
                  // FuctionHelp().changeIndex(index: doctorData[index]["value"]);
                  Provider.of<CommonFunction>(context, listen: false)
                      .changingStreams(
                          stream: Provider.of<CommonFunction>(context,
                                  listen: false)
                              .streamFuctionPro(
                                  doctorId: doctorData[index][
                                      "value"])); // StreamHelper().changingStreams(
                  //     stream: FuctionHelp()
                  //         .streamFuction(doctorId: doctorData[index]["value"]));
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

  Stream<List<UserModal>> streamFuction({doctorId}) {
    print("streamis $doctorId");
    return FirebaseFirestore.instance
        .collection('token')
        .where("doctor_id", isEqualTo: doctorId == null ? 1 : doctorId)
        .where(
          "status",
          isEqualTo: "open",
        )
        .snapshots()
        .map((snapshots) =>
            snapshots.docs.map((e) => (UserModal.fromJson(e.data()))).toList());
  }
}

class StreamHelper {
  static Stream<List<UserModal>>? changeStream;

  changingStreams({stream}) {
    changeStream = stream;
  }
}

//
// Stream<List<UserModal>> geetingUserData({doctorid}) {
//   print(doctorid);
//   print('llllllllllll');
//   return FirebaseFirestore.instance
//       .collection('token')
//       .where(
//     "status",
//     isEqualTo: "open",
//   )
//       .snapshots()
//       .map((snapshots) =>
//       snapshots.docs.map((e) => (UserModal.fromJson(e.data()))).toList());
// }
