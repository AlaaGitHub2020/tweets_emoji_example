import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/core/database_helper.dart';
import 'package:tweets_emoji_example/presentation/sql_lite_version/widgets/the_size_of_database.dart';

class SizeOfDBWidget extends StatelessWidget {
  const SizeOfDBWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseHelper.instance.getDatabaseSizeCount(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return snapshot.data == null
              ? Container()
              : TheSizeOfDatabase(snapshot: snapshot);
        });
  }
}
