import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';

class TheSizeOfDatabase extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const TheSizeOfDatabase({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        "${S.of(context).theSizeOfDatabase}"
        "${snapshot.data}",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
