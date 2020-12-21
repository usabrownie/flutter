// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matching Game',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Game'),
//        actions: [
//          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
//        ],
      ),
      body: //Image.asset('assets/images/puppy.jpg'),
        _buildSuggestions(),
    );
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }

  Widget _buildSuggestions() {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(10, (index) {

        if(index.isOdd) return Center(
          child: Image.asset('assets/images/puppy.jpg'),
        );
        else return Center(
          child: Image.asset('assets/images/kitty.jpg'),
        );
      }),
    );

//    return ListView.builder(
//      padding: EdgeInsets.all(16.0),
//      itemBuilder: /*1*/ (context, i) {
//        if(i.isOdd) return Divider(); /*2*/
//
//        final index = i ~/ 2; /*3*/
//        if(index >= _suggestions.length) {
//          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//        }
//        return _buildRow(_suggestions[index]);
//      });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
              (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  )
                );
              }
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
              body: ListView(children: divided),
          );
        }
      )
    );
  }
}
