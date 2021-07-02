import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'constant/const.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../DBData/getNews.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'constant/const.dart';
import 'openNews.dart';

class WuwCon extends StatefulWidget {
  @override
  _WuwCon createState() => _WuwCon();
}

class _WuwCon extends State<WuwCon> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: wuw,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
        );
      }),
    );
  }
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      });
}

class Wuw extends StatefulWidget {
  Wuw({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Wuw createState() => _Wuw();
}

class _Wuw extends State<Wuw> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  List _data = [];

  late int cnt = 0;

  var url = Uri.parse('https://cdsnet.kr/flutterConn/wuwAll.php');

  _fetchTodayNews() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          News showNews =
          News(nnews["title"], nnews['email'], nnews['dates'], nnews["id"]);
          setState(() {
            _data.add(showNews);
          });
        }
        cnt = news.length;
      } else {
        print('Error');
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    if (cnt == 0) {
      _fetchTodayNews();
    }
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.yellow,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text("Whats up Wednesday", textAlign: TextAlign.center),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              background: Image.asset(
                'images/two.png',
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withOpacity(0.15),
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                News showing = _data[index];
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                        const EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: Text(
                          'Most recent',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                wuw =
                                    'https://cdsnet.kr/wuwOpen.php?id=' +
                                        showing.id;
                              });
                              print(link);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WuwCon(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    showing.title,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    showing.dates,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Posted by: ' + showing.email,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (index == 1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                        const EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: Text(
                          'Older Newsletter ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                wuw =
                                    'https://cdsnet.kr/wuwOpen.php?id=' +
                                        showing.id;
                              });
                              print(link);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WuwCon(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    showing.title,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    showing.dates,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Posted by: ' + showing.email,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            wuw =
                                'https://cdsnet.kr/wuwOpen.php?id=' +
                                    showing.id;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WuwCon(),
                            ),
                          );
                          print(link);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                showing.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                showing.dates,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Posted by: ' + showing.email,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              childCount: cnt,
            ),
          ),
        ],
      ),
    );
  }
}
