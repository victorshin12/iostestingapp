// @dart=2.9
import 'dart:io';

import 'package:apitesting/includingfiles/documents/privacy.dart';
import 'package:apitesting/includingfiles/documents/terms.dart';
import 'package:apitesting/version.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'includingfiles/About.dart';
import 'includingfiles/Dates.dart';
import 'includingfiles/constant/constants.dart';
import 'includingfiles/categories.dart';
import 'includingfiles/homepage/homepages.dart';
import 'includingfiles/liveSports.dart';
import 'includingfiles/lunch.dart';
import 'package:mailto/mailto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final fontColor = Colors.grey[700];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: 220,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                              image: AssetImage('images/cds.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    //ListTile(
                    //  leading: Icon(Icons.info),
                    //  title: Text(
                    //    'About',
                    //    style: TextStyle(
                    //      color: fontColor,
                    //      fontSize: 18,
                    //    ),
                    //  ),
                    //  onTap: () {
                    //    //
                    //  },
                    //),
                    ListTile(
                      leading: Icon(Icons.mail),
                      title: Text(
                        'Contact',
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 18,
                        ),
                      ),
                      onTap: launchMailto,
                    ),
                    //ListTile(
                    //  leading: Icon(Icons.notifications),
                    //  title: Text(
                    //    'Notifications',
                    //    style: TextStyle(
                    //      color: fontColor,
                    //      fontSize: 18,
                    //    ),
                    //  ),
                    //  onTap: () {},
                    //),
                    ListTile(
                      leading: Icon(Icons.contact_page),
                      title: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Terms()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shield),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicy()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    "Version " + version,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      icon: Icon(Icons.menu)),
                  Expanded(
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: kGrey1,
                      unselectedLabelStyle: kNonActiveTabStyle,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      indicatorColor: Colors.black,
                      labelStyle: kActiveTabStyle.copyWith(fontSize: 25.0),
                      tabs: [
                        Tab(text: "All"),
                        Tab(text: "Category"),
                        Tab(text: "Lunch"),
                        Tab(text: "Athletics"),
                        Tab(text: "Dates"),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        body: TabBarView(
          children: [
            AllTabView(),
            Cate(),
            Lunch(),
            Sports(),
            Dates(),
          ],
        ),
      ),
    );
  }

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['wooseokshin2023@daltonschool.kr', 'gkim2023@daltonschool.kr'],
      subject: 'CDS App Feedback',
      body: getOS() + " " + version,
    );

    await launch('$mailtoLink');
  }

  String getOS() {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "iOS";
    }
    return "";
  }
}
