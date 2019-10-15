import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './components/notification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "事件提醒",
      theme: ThemeData(
        primarySwatch: Colors.purple, //can't be black or white 
      ),
      home: EventGenerator(), 
    );
  }
}
 
class EventGenerator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EventGeneratorState();

}

class EventGeneratorState extends State<EventGenerator> {
  final contentController = TextEditingController();
  final _notificationWidget = NotificationWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildeNavigator(),
        title: Text("新建事件s"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: (){},)
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigatorState(),
    );
  }

  @override
  void initState() {
    super.initState();

    contentController.addListener(_onDataChange);
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  void _onDataChange(){
    _notificationWidget.channelId = "dd";
    _notificationWidget.channelName = "标题1";
    _notificationWidget.description = contentController.text;
  }

  //构建AppBar
  Widget _buildeNavigator(){
    //v1.静态文字，静态半屏弹窗 (AppBar | NavigationToolbar)
    //v2.半屏弹窗内容增加更多功能
    return NavigationToolbar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: (){},),

    );
  }
  
  //构建主体
  Widget _buildBody(){
    return Column(
      children: <Widget>[
        _header(),
        _form(),
        _notificationWidget,
      ],
    );
  }

  //构建头部
  Widget _header(){
    //v1:静态文字
    //v2:今日事件，点击跳转编辑
    return Container(
      padding: const EdgeInsets.only(top: 30.0),
      child: Text(
        "共有n项提醒",
        textAlign: TextAlign.center,
      )
    );
  }

  //构建输入信息输入区域及提交
  Widget _form(){
    
    //v1:一行文字
    //v2:标题、正文、时间、事件强度
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child : TextField(
        controller: contentController,
        decoration: InputDecoration(
        hintText: "在此输入提醒内容",
        prefixText: "输入："
      ),
    )
    );
  }


}

class BottomNavigatorState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavigatorState();

}

class _BottomNavigatorState extends State<BottomNavigatorState> {

  int _currentIndex = 1;

  void _onItemTapped(int index){
    if(mounted) {
      setState(() {
        this._currentIndex = index; 
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 20.0,
      onTap: _onItemTapped,
      currentIndex: _currentIndex,
      fixedColor: Colors.deepOrange,
      
      items: <BottomNavigationBarItem>[
        //链接、聊天、首页（居中）、历史消息、我的
        BottomNavigationBarItem(
          title: Text("链接"),
          icon: Icon(Icons.link),
          
        ),
        BottomNavigationBarItem(
          title: Text("世界聊天"),
          icon: Icon(Icons.chat),
        ),
        BottomNavigationBarItem(
          title: Text("首页"),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text("历史消息"),
          icon: Icon(Icons.history),
        ),
        BottomNavigationBarItem(
          title: Text("我的"),
          icon: Icon(Icons.person),
        ),
      ],
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

  //点击进入新页面
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
