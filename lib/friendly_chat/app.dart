import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './chat_message.dart';

class FriendlyChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('FriendlyChat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  // ChatScreenStateオブジェクトが不要になった際に呼び出されるメソッド
  // メッセージが表示中の画面から非表示になった際に、アニメーションの挙動も削除する
  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor
            ),
            child: _buildTextComposer(),
          )
        ]
      ),
      decoration: Theme.of(context).platform == TargetPlatform.iOS
        ? new BoxDecoration(                                     //new
          border: new Border(                                  //new
            top: new BorderSide(color: Colors.grey[200]),      //new
          ),                                                   //new
        )
        : null,
    );
  }

  // テキスト入力用のWidget
  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(hintText: "Send a message")
              )
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                ? new CupertinoButton(
                  child: new Text("Send"),
                  onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
                )
                : new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
                ),
            )
          ]
        )
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    // ChatScreenStateクラスのbuildメソッドが再実行される
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }
}
