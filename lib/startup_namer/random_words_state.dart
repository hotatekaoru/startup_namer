import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// StatefulWidgetは、Stateを持つWidget
// RandomWordsStateでstate管理を行う
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // constは、コンパイル時に値が確定するアクセス修飾子
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  // finalは、値を一度代入後に変更ができなくなるアクセス修飾子
  // ここでいう「値」は、<WordPair>[]のこと
  // そのあとに、_suggestions.addみたいなことはfinalでは可能
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
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

  // Widgetの中にWidgetを格納することもできる。このままだと可読性悪いな・・・
  // アンスコから始まるWidgetはprivateとして扱われる(Classなども)
  Widget _buildRow(WordPair pair) {
    // 型予測してくれる
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          // _savedはSet<WordPair>型
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          // Set<WordPair>型の_saved毎に、ListTileWidgetのIterableに設定する
          // IterableはListの抽象クラス
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

