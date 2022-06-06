import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/presentation/home/widgets/try_with_firebase_btn.dart';
import 'package:tweets_emoji_example/presentation/home/widgets/try_with_sql_lite_btn.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(S.of(context).tweetsEmoji),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            TryWithFirebaseBtn(),
            TryWithSQLLiteBtn(),
          ],
        ),
      ),
    );
  }
}
