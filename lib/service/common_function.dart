import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Modal/modal_datas.dart';

class CommonFunction extends ChangeNotifier {
  List<Map<String, dynamic>> userDatas = [];
  Stream<List<UserModal>>? changeStreamPro;
  var assisDocs;
  var doctorsList;
  List searchAllDcos = [];
  Stream<List<DoctorModal>>? searchDoctor;

  changingStreams({stream}) {
    changeStreamPro = stream;
    notifyListeners();
  }

  searchChangingStream({stream}) {
    searchDoctor = stream;
  }

  List<String> userNameList = [
    "Joe",
    "Emma",
    "Jack",
    "Goku",
    "Vegeta",
    "Naruto",
    "Sasuke",
    "Gohan",
    "Boruto",
    "Jin"
  ];
  List<int> userNumberList = [
    124456677,
    234567643,
    234579765,
    345212456,
    434567997,
    999764345,
    345664432,
    345466365,
    234647537,
    772399339,
  ];

  genarateList() async {
    userDatas = await List.generate(
      10,
      (index) => {
        "user_id": "${index}",
        "user_name": "${userNameList[index]}",
        "phone_number": "${userNumberList[index]}"
      },
    );
    notifyListeners();
  }

  removeList({list, index}) {
    list.removeAt(index);
    print(list);
    notifyListeners();
  }

  Stream<List<UserModal>> streamFuctionPro({doctorId}) {
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

  Stream<List<DoctorModal>> doctorsSearchStream({givenText}) {
    return FirebaseFirestore.instance
        .collection("doctors")
        .where('phone',
            isGreaterThanOrEqualTo: givenText, isLessThan: givenText + 'z')
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((e) => (DoctorModal.fromJson(e.data())))
            .toList());
  }

  Stream<List<DoctorModal>> streamDoctors() {
    return FirebaseFirestore.instance.collection("doctors").snapshots().map(
        (snapshots) => snapshots.docs
            .map((e) => (DoctorModal.fromJson(e.data())))
            .toList());
  }

  Stream<List<AssistantsModal>> streamAssistant({id}) {
    return FirebaseFirestore.instance
        .collection("Assistants")
        .where("phonenumber", isEqualTo: id)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((e) => (AssistantsModal.fromJson(e.data())))
            .toList());
  }

//  Stream<List<DoctorModal>> streamSearchDoc({id}){
//     return FirebaseFirestore.instance.collection("doctors").where("p").snapshots().map((snapshots) => snapshots.d)
// }

  getAssisDocs({id}) async {
    await FirebaseFirestore.instance
        .collection("Assistants")
        .doc(id)
        .snapshots()
        .listen((event) {
      print(event.data()!["assigneddoctors"]);
      doctorsList = event.data()!["assigneddoctors"];
      print(doctorsList);
      notifyListeners();
    });
  }
}
