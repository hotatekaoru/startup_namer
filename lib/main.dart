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
                  leading: Icon(Icons.insert_emoticon),
                ),
              ),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute<Null>(
                  settings: RouteSettings(name: _pageItem.routeName),
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
  String routeName;
  Widget nextScreenWidget;

  // これがsetterの代わりになり、キーワード引数を伴ってnewできるようになる
  @required
  Page({this.columnName, this.routeName, this.nextScreenWidget});
}

List<Page> pageList() {
  final list = List<Page>();
  list.addAll([
    Page(columnName: 'StartupNamer', routeName: 'startup_namer', nextScreenWidget: StartupNamer()),
  ]);
  return list;
}
