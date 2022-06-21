import 'package:flutter/material.dart';
import 'package:supportclone/Modal/modal_datas.dart';
import 'package:supportclone/common_widgets/common_appbar.dart';
import 'package:supportclone/common_widgets/common_text.dart';
import 'package:supportclone/common_widgets/commoncircleavatar.dart';
import 'package:provider/provider.dart';
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
              return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext contex, int index) {
                    return Stack(
                      children: [
                        Container(
                          height: h * 0.09,
                          width: w,
                          margin: EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        Positioned(
                          top: h * 0.005,
                          left: w * 0.02,
                          child: CommonCircularAvatar(
                            radius: h * 0.04,
                            backgroundColor: Colors.blueGrey,
                            content: CommonText(
                              text:
                                  "${snapshot.data![index].doc_firstName.toString().substring(0, 1)}",
                              textSize: 25,
                            ),
                          ),
                        ),
                        Positioned(
                          top: h * 0.007,
                          left: w * 0.2,
                          child: CommonText(
                            text:
                                "${snapshot.data![index].doc_firstName} ${snapshot.data![index].doc_lastName}",
                            textSize: 18,
                            textColor: Colors.grey,
                          ),
                        ),
                        Positioned(
                          bottom: h * 0.012,
                          left: w * 0.2,
                          child: CommonText(
                            text: "ID: 4545545455",
                            textSize: 15,
                            textColor: Colors.grey,
                          ),
                        )
                      ],
                    );
                  });
            }),
      ),
      bottomSheet: Container(
        height: h * 0.1,
        width: w,
        child: Center(
          child: Container(
            height: h * 0.06,
            width: w * 0.8,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: CommonText(
                text: "ADD DOCTORS",
                textColor: Colors.white,
                textSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
