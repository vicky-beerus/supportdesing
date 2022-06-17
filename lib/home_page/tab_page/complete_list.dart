import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Modal/modal_datas.dart';
import '../../common_widgets/common_text.dart';
import '../../common_widgets/commoncircleavatar.dart';
import '../../service/common_function.dart';

class CompleteList extends StatefulWidget {
  const CompleteList({Key? key}) : super(key: key);

  @override
  State<CompleteList> createState() => _OpenListState();
}

class _OpenListState extends State<CompleteList> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return StreamBuilder<List<UserModal>>(
        stream: geetingUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ReorderableListView.builder(
              key: UniqueKey(),
              onReorder: (int oldIndex, int newIndex) {
                if (newIndex >=
                    Provider.of<CommonFunction>(context, listen: false)
                        .userDatas
                        .length) return;
                print(oldIndex);
                print(newIndex);
                setState(() {
                  var reIndex =
                      Provider.of<CommonFunction>(context, listen: false)
                          .userDatas[oldIndex];
                  Provider.of<CommonFunction>(context, listen: false)
                          .userDatas[oldIndex] =
                      Provider.of<CommonFunction>(context, listen: false)
                          .userDatas[newIndex];
                  Provider.of<CommonFunction>(context, listen: false)
                      .userDatas[newIndex] = reIndex;
                  print("reindex $reIndex");
                });
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data![index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    update(id: snapshot.data![index].id, status: "open");
                  },
                  background: Container(
                    height: h * 0.1,
                    width: w,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.green)),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: CommonText(
                      text: "Move To \nOpen",
                      textSize: 15,
                      textColor: Colors.green,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Card(
                          child: Container(
                        height: h * 0.1,
                        width: w,
                      )),
                      Positioned(
                        top: h * 0.005,
                        left: w * 0.03,
                        child: Container(
                            height: h * 0.1,
                            width: w * 0.15,
                            // color: Colors.blue,
                            padding: EdgeInsets.all(2),
                            child: Container(
                              height: h * 0.08,
                              width: w * 0.05,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: CommonText(
                                text:
                                    "${snapshot.data![index].name.toString().substring(0, 1)}",
                                textSize: 25,
                                textColor: Colors.white,
                              ),
                            )),
                      ),
                      Positioned(
                        top: h * 0.02,
                        left: w * 0.2,
                        child: CommonText(
                          text: "Name: ${snapshot.data![index].name}",
                          textSize: 20,
                          textColor: Colors.blueGrey,
                        ),
                      ),
                      Positioned(
                        bottom: h * 0.02,
                        left: w * 0.2,
                        child: CommonText(
                            text: "Age: ${snapshot.data![index].age}",
                            textSize: 14,
                            textColor: Colors.blueGrey),
                      ),
                      Positioned(
                        bottom: h * 0.02,
                        right: w * 0.05,
                        child: CommonText(
                            text: "Ph: ${snapshot.data![index].phone}",
                            textSize: 14,
                            textColor: Colors.blueGrey),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Stream<List<UserModal>> geetingUserData() => FirebaseFirestore.instance
      .collection('token')
      .where("status", isEqualTo: "complete")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((e) => (UserModal.fromJson(e.data()))).toList());

  update({id, status}) {
    final updating = FirebaseFirestore.instance
        .collection('token')
        .doc(id)
        .update({"status": status});
  }
}
