//import 'package:english_words/english_words.dart';
//import 'package:flutter/material.dart';
//
//class RandomWords extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return RandomWordsState();
//  }
//}
//
//class RandomWordsState extends State<RandomWords> {
//  final _suggestions = <WordPair>[];
//  final _saved = Set<WordPair>();
//  final _biggerFont = const TextStyle(fontSize: 18.0);
//  final _titleFont = const TextStyle(color: Colors.black);
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
////    var wordPair = new WordPair.random();
////    return new Text(wordPair.asPascalCase);
//    return new Scaffold(
//      appBar: AppBar(
//        title: Text(
//          '这是什么玩意儿',
//          style: _titleFont,
//        ),
//        centerTitle: true,
//        actions: <Widget>[
//          new IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
//        ],
//      ),
//      body: _buildSuggestion(),
//    );
//  }
//
//  Widget _buildSuggestion() {
//    return ListView.builder(
//      padding: const EdgeInsets.all(1.0),
//      itemBuilder: (context, i) {
//        if (i.isOdd)
//          return Divider(
//            height: .0,
//          );
//        final index = i ~/ 2;
//        if (index >= _suggestions.length) {
//          _suggestions.addAll(generateWordPairs().take(10));
//        }
//        return _buildRow(_suggestions[index]);
//      },
//    );
//  }
//
//  Widget _buildRow(WordPair pair) {
//    final alreadySaved = _saved.contains(pair);
//    return ListTile(
//      title: Text(
//        pair.asPascalCase,
//        style: _biggerFont,
//      ),
//      dense: true,
//      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
//          color: alreadySaved ? Colors.red : null),
//      onTap: () {
//        setState(() {
//          if (alreadySaved) {
//            _saved.remove(pair);
////            Navigator.push(context, MaterialPageRoute(builder: (context) {
////              return RandomWords();
////            }));
//          } else {
//            _saved.add(pair);
//          }
//        });
//      },
//    );
//  }
//
//  void _pushSaved() {
//    Navigator.of(context).push(
//      new MaterialPageRoute(builder: (context) {
//        final title = _saved.map((pair) {
//          return ListTile(
//            title: Text(
//              pair.asPascalCase,
//              style: _biggerFont,
//            ),
//            dense: true,
//          );
//        });
//        final divided =
//            ListTile.divideTiles(tiles: title, context: context).toList();
//        return Scaffold(
//          appBar: AppBar(
//            title: Text(
//              "什么┏",
//              style: _titleFont,
//            ),
//            centerTitle: true,
////            leading: Icon(
////              Icons.chevron_left,
////              color: Colors.black54,
////            ),
//          ),
//          body: ListView(children: divided),
//        );
//      }),
//    );
//  }
//}
