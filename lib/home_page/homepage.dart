import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportclone/DRAWER/doctor_page.dart';
import 'package:supportclone/common_widgets/common_text.dart';
import 'package:supportclone/common_widgets/common_textformfield.dart';
import 'package:supportclone/home_page/doctor_lists.dart';
import 'package:supportclone/home_page/tab_page/complete_list.dart';
import 'package:supportclone/home_page/tab_page/missed_list.dart';
import 'package:supportclone/home_page/tab_page/open_list.dart';

import '../generate_token/genaratetoken.dart';
import '../service/common_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var datas;

  @override
  void initState() {
    Provider.of<CommonFunction>(context, listen: false).changingStreams(
        stream: Provider.of<CommonFunction>(context, listen: false)
            .streamFuctionPro(doctorId: "1")); // Strea
    Provider.of<CommonFunction>(context, listen: false).genarateList();
    // Provider.of<CommonFunction>(context, listen: false).geetingUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Container(
                height: h * 0.1,
                width: w,
                decoration: BoxDecoration(color: Colors.blueGrey),
              )),
              Container(
                height: h * 0.08,
                width: w,
                // color: Colors.red,
                child: ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorPage()));
                    },
                    trailing: Icon(
                      Icons.medical_services,
                      color: Colors.blueGrey,
                    ),
                    title: CommonText(
                      text: "Doctor",
                      textSize: 17,
                    )),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Nalama"),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => GenerateToken()));
                },
                icon: const Icon(Icons.add_box_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.watch_later_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle))
          ],
        ),
        body: Column(
          children: [
            DoctorList(),
            Container(
              height: h * 0.08,
              width: w,
              color: Colors.blueGrey,
              child: Center(
                child: CommonTextFormField(
                  bodyColor: Colors.white,
                  suffixWidget: Icon(
                    Icons.search,
                    color: Colors.blueGrey,
                  ),
                  height: h * 0.06,
                  width: w * 0.9,
                  hintText: "search",
                ),
              ),
            ),
            Container(
                height: h * 0.55,
                width: w,
                child: TabBarView(
                    children: [MissedList(), OpenList(), CompleteList()])),
          ],
        ),
        bottomSheet: Container(
          height: h * 0.08,
          width: w,
          child: Center(
            child: Container(
              height: h * 0.06,
              width: w * 0.95,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                  labelStyle: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 18),
                  unselectedLabelStyle: const TextStyle(
                      fontStyle: FontStyle.normal, fontSize: 15),
                  indicatorColor: Colors.blueGrey,
                  indicator: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30)),
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      text: "Missed",
                    ),
                    Tab(
                      text: "Open",
                    ),
                    Tab(
                      text: "complete",
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
