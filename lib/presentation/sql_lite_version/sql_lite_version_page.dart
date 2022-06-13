import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/sql_tweet_watcher/sql_tweet_watcher_cubit.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_actor/tweet_actor_bloc.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/injection.dart';
import 'package:tweets_emoji_example/presentation/routes/router.gr.dart';
import 'package:tweets_emoji_example/presentation/sql_lite_version/widgets/sql_version_body.dart';

class SQLLiteVersionPage extends StatelessWidget {
  const SQLLiteVersionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(S.of(context).tweetsEmojiWithSQLLite),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TweetActorBloc>(
            create: (context) => getIt<TweetActorBloc>(),
          ),
          BlocProvider<SqlTweetWatcherCubit>(
            create: (context) => SqlTweetWatcherCubit(),
          ),
        ],
        child: const SQLLiteVersionBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.router.push(
              AddNewTweetRoute(editedTweet: Tweet.empty(), fromSQL: true));
        },
        tooltip: S.of(context).addNewTweet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
