import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';

class NoDataInTheDB extends StatelessWidget {
  const NoDataInTheDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text(
          S.of(context).noDataInTheDB,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
