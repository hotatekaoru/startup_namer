import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './startup_namer/app.dart';
import './friendly_chat/app.dart';
import './firebase_sample/app.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      home: new TopPage(),
    );
  }

  final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );
}

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => new _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    final _pggeList = pageList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Tutorial"),
      ),
      body: new Center(
        child: ListView(
          children: List.generate(_pggeList.length, (index) {
            final _pageItem = _pggeList[index];
            return InkWell(
              child: Card(
                child: ListTile(
                  title: Text(_pageItem.columnName),
                  leading: Icon(_pageItem.columnIcon),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute<void>(
                  builder: (BuildContext context) => _pageItem.nextScreenWidget
                ));
              },
            );
          }),
        ),
      ),
    );
  }
}

// structにしたいところだけど、Dartにはstructがない・・・
class Page {
  String columnName;
  IconData columnIcon;
  Widget nextScreenWidget;

  // これがsetterの代わりになり、キーワード引数を伴ってnewできるようになる
  @required
  Page({this.columnName, this.columnIcon, this.nextScreenWidget});
}

List<Page> pageList() {
  final list = List<Page>();
  list.addAll([
    Page(columnName: 'StartupNamer', columnIcon: Icons.insert_emoticon, nextScreenWidget: StartupNamer()),
    Page(columnName: 'FriendlyChat', columnIcon: Icons.chat, nextScreenWidget: FriendlyChat()),
    Page(columnName: 'FirebaseSample', columnIcon: Icons.store_mall_directory, nextScreenWidget: FirebaseSample()),
  ]);
  return list;
}

