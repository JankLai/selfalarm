

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
//import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
//import 'package:dshared_preferences/shared_preferences.dart';

void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "startup name generator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 19.0);

  final Set<WordPair> _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("无限组合词"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
      // bottomNavigationBar: BubbleBottomBar(

      // ),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: const Text("saved suggestions"),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.list), onPressed: _pushedAgain)
          ],
        ),
        body: new ListView(children: divided),
      );
    }));
  }

  void _pushedAgain() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: const Text("this is a test page"),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _textField(),
              _textFormField(),
              _raisedButton(),

              _iconButton(),
              _text(),
            ],
          ));
    }));
  }

  //输入线
  Widget _textFormField() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        obscureText: true, //Use secure text for passwords
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_balance_wallet,color:Colors.blue),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.black),
          labelText: 'Type your password',
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  //输入框
  Widget _textField() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle,color: Colors.blue),
          hintText: "Enter your name",
          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.blue),
          enabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
      ),
    );
  }

  //按钮
  Widget _raisedButton() {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: RaisedButton(
          onPressed: () {
            debugPrint("I'm awesome"); //控制台输出
          },
          textColor: Colors.white,
          color: Colors.blueAccent,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.white,
          highlightColor: Colors.orangeAccent,
          elevation: 4.0,
          child: Text('RaisedButton'),
        ),
      ),
    );
  }

  Widget _iconButton() {
    bool _clicked = true;
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: 
          IconButton(
          
          color: Colors.orangeAccent,
          icon: _clicked ? Icon(Icons.star) : Icon(Icons.star_border),
          disabledColor: Colors.grey,
          highlightColor: Colors.black38,
          onPressed: () {
            debugPrint("星星被点击了");  
            setState(() { //not useful
             if (_clicked)
                _clicked = false;
              else
                _clicked = true;
            });
          },
        ),
      ),
    );
  }

  //text
  Widget _text(){
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Text(
                "Flutter is awesome",
          style: new TextStyle(
            fontSize: 18.0,
            color: Colors.greenAccent,
            fontWeight: FontWeight.w500,
            fontFamily: "Roboto",
          ),
        ),
      ),
    );
  }

  //

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

//跑马灯
// class _MarqueeContinuousState extends State<MarqueeContinuous>{
//   ScrollController _controller;
//   Timer _timer;
//   double _offset=0.0;
  
//   @override
//   void initState(){
//     super.initState();
//     _controller=ScrollController(initialScrollOffset: _offset);
//     _timer=Timer.periodic(widget.duration, (timer){
//       double newOffset=_controller.offset+widget.stepOffset;
//       if(newOffset!=_offset){
//         _offset=newOffset;
//         _controller.animateTo(_offset,
//               duration: widget.duration,curve: Curves.linear);
//       }
//     });
//   }

//   @override 
//   void dispose(){
//     _timer.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       controller: _controller,
//       itemBuilder: (context,index){
//         return widget.child;
//       },
//     );
//   }

  
// }
