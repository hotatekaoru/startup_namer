import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  final String name;

  NewScreen({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('New Screen'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$name',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 22.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, {'greeting': 'Hello $name!'});
                },
                child: Text('Greeting'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
