import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// StatefulWidgetは、Stateを持つWidget
// RandomWordsStateでstate管理を行う
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {

    // constは、コンパイル時に値が確定するアクセス修飾子
    // サンプルコードではfinalになってたけど、constの方が良さげ
    const TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

    // finalは、値を一度代入後に変更ができなくなるアクセス修飾子
    // ここでいう「値」は、<WordPair>[]のこと
    // そのあとに、_suggestions.addみたいなことはfinalでは可能
    final List<WordPair> _suggestions = <WordPair>[];

    // Widgetの中にWidgetを格納することもできる。このままだと可読性悪いな・・・
    // アンスコから始まるWidgetはprivateとして扱われる(Classなども)
    Widget _buildRow(WordPair pair) {
      return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
    }

    Widget _buildSuggestions() {
      return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 枠線(Divider)のみのItemと、文字列が入ったItemを交互に返してる
        // 文字列が入ったItemの最下部に枠線入れる方が良さそうだけど・・・
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
      );
    }

    return new Scaffold (                   // Add from here...
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

