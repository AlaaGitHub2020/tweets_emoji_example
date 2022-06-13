import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/sql_tweet_watcher/sql_tweet_watcher_cubit.dart';
import 'package:tweets_emoji_example/presentation/core/loading.dart';
import 'package:tweets_emoji_example/presentation/sql_lite_version/widgets/size_of_db_widget.dart';
import 'package:tweets_emoji_example/presentation/sql_lite_version/widgets/tweet_list_from_db.dart';

class SQLLiteVersionBody extends StatelessWidget {
  const SQLLiteVersionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SqlTweetWatcherCubit, SqlTweetWatcherState>(
      builder: (BuildContext context, SqlTweetWatcherState state) {
        if (state is SqlDatabaseLoading) {
          return const Loading();
        }
        return SingleChildScrollView(
          primary: true,
          child: Column(
            children: const [
              SizeOfDBWidget(),
              TweetListFromDB(),
            ],
          ),
        );
      },
    );
  }
}
