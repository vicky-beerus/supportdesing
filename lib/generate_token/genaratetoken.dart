import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supportclone/common_widgets/common_text.dart';
import 'package:supportclone/home_page/homepage.dart';
import 'package:provider/provider.dart';
import 'package:supportclone/service/common_function.dart';
import '../Modal/modal_datas.dart';
import '../common_widgets/common_appbar.dart';
import '../common_widgets/common_selectformfield.dart';
import '../common_widgets/common_textformfield.dart';

class GenerateToken extends StatefulWidget {
  const GenerateToken({Key? key}) : super(key: key);

  @override
  State<GenerateToken> createState() => _GenerateTokenState();
}

class _GenerateTokenState extends State<GenerateToken> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController doctorController = TextEditingController();

  var countryCode;
  var doctDetails;
  List<Map<String, dynamic>> data = [];

  List<Map<String, dynamic>> doctorData = [
    {"value": "1", "label": "Hari"},
    {"value": "2", "label": "Perasana"}
  ];
  @override
  void initState() {
    // Provider.of<CommonFunction>(context, listen: false).streamDoctors();

    getDoctorsData().then((value) {
      setState(() {
        doctDetails = value;
      });

      for (var i = 0; i < doctDetails.length; i++) {
        setState(() {
          data.add({
            "label": doctDetails[i]["doc_firstname"],
            "value": doctDetails[i]["doc_id"]
          });
        });
      }
    });
    print(data);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey,
        appBar: PreferredSize(
          child: CommonAppBar(
            text: "Generate Token",
            leadinWant: false,
          ),
          preferredSize: Size.fromHeight(h * 0.08),
        ),
        body: Container(
          height: h,
          width: w,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.05,
              ),
              Container(
                height: h * 0.55,
                width: w * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.05,
                    ),
                    CommonTextFormField(
                      height: h * 0.06,
                      width: w * 0.9,
                      controller: nameController,
                      hintText: "Name",
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Container(
                      height: h * 0.08,
                      width: w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: h * 0.06,
                            width: w * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.4))),
                            child: CountryCodePicker(
                              initialSelection: 'IN',
                              showFlag: false,
                              onChanged: (val) {
                                setState(() {
                                  countryCode = val;
                                });
                              },
                            ),
                          ),
                          CommonTextFormField(
                            height: h * 0.06,
                            width: w * 0.7,
                            controller: phoneNumberController,
                            hintText: "Phone",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    CommonTextFormField(
                      height: h * 0.06,
                      width: w * 0.9,
                      controller: ageController,
                      hintText: "Age",
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    CommonSelectForm(
                      list: doctorData,
                      height: h * 0.06,
                      width: w * 0.9,
                      textEditingController: doctorController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Container(
                height: h * 0.06,
                width: w,
                child: Center(
                  child: Container(
                    height: h * 0.06,
                    width: w * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              generateTokenPost();
                            },
                            icon: Icon(
                              Icons.generating_tokens,
                              color: Colors.blueGrey,
                            )),
                        CommonText(
                          text: "Generate Token",
                          textSize: 15,
                          textColor: Colors.blueGrey,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // post({name}) async {
  //   final posting = FirebaseFirestore.instance.collection('users').doc();
  //   final user = UserModal(
  //       id: posting.id,
  //       userName: name,
  //       age: 21,
  //       dob: DateFormat("dd-MM-yyyy").format(DateTime.now()));
  //   final json = user.toJosn();
  //
  //   await posting.set(json);
  // }

  generateTokenPost() async {
    final posting = FirebaseFirestore.instance.collection('token').doc();
    final token = UserModal(
        id: posting.id,
        date: DateFormat("dd-MM-yyyy").format(DateTime.now()),
        doctorId: "2",
        status: "open",
        phone: phoneNumberController.text.toString(),
        name: nameController.text.toString(),
        age: ageController.text.toString());

    final json = token.toJson();
    await posting.set(json);
  }

  Future getDoctorsData() async {
    return await FirebaseFirestore.instance
        .collection("doctors")
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((e) => (DoctorModal.fromJson(e.data())))
            .toList());
  }
}
