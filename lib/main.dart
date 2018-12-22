import 'package:flutter/material.dart';
import './random_words_state.dart';

void main() => runApp(new MyApp());

// StatelessWidgetは、Stateを持たないWidget
// Stateを監視する必要があるWidgetはRandomWordsに内包させる
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
}
