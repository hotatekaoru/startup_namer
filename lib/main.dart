import 'package:flutter/material.dart';
import './startup_namer/app.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new TopPage(),
    );
  }
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
  ]);
  return list;
}
