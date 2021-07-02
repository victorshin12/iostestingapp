import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  double widthOfButton = 130;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 70,
          child: Image.asset('images/cdslogo.png'),
        ),
        SizedBox(
          height: 40,
        ),
      
        SizedBox(
          width: widthOfButton,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue))),
            ),
            child: Text("App Website"),
            onPressed: _launchWebsite,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          width: widthOfButton,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue))),
            ),
            child: Text("Contact"),
            onPressed: launchMailto,
          ),
        ),
        SizedBox(
          height: 80,
        ),
      ],
    );
  }

  _launchWebsite() async {
    const url = 'https://cdsnet.kr';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchSchool() async {
    const url = 'https://daltonschool.kr';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['wooseokshin2023@daltonschool.kr', 'gkim2023@daltonschool.kr'],
      subject: 'CDS App Feedback',
      body: '',
    );

    await launch('$mailtoLink');
  }
}
