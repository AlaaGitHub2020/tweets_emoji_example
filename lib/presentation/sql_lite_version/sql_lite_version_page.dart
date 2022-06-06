import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';

class SQLLiteVersionPage extends StatelessWidget {
  const SQLLiteVersionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(S.of(context).tweetsEmojiWithSQLLite),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: S.of(context).addNewTweet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
