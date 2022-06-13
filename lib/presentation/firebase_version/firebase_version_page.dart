import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_actor/tweet_actor_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_watcher/tweet_watcher_bloc.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/injection.dart';
import 'package:tweets_emoji_example/presentation/core/snackbars.dart';
import 'package:tweets_emoji_example/presentation/firebase_version/widgets/firebase_version_body.dart';
import 'package:tweets_emoji_example/presentation/routes/router.gr.dart';

class FirebaseVersionPage extends HookWidget {
  const FirebaseVersionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(S.of(context).tweetsEmojiWithFirebase),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TweetWatcherBloc>(
            create: (context) => getIt<TweetWatcherBloc>()
              ..add(const TweetWatcherEvent.watchAllStarted()),
          ),
          BlocProvider<TweetActorBloc>(
            create: (context) => getIt<TweetActorBloc>(),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<TweetActorBloc, TweetActorState>(
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  deleteFailure: (state) {
                    SnackBars.showError(
                      context,
                      state.tweetFailure.map(
                          unexpected: (_) => S.of(context).unexpected,
                          platFormServerFailure: (_) =>
                              S.of(context).platFormServerFailure,
                          unableToUpdate: (_) => S.of(context).unableToUpdate,
                          platFormSQLDataBaseFailure: (_) =>
                              S.of(context).platFormSQLDataBaseFailure),
                    );
                  },
                );
              },
            ),
          ],
          child: const FirebaseVersionBody(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(
              AddNewTweetRoute(editedTweet: Tweet.empty(), fromSQL: false));
        },
        tooltip: S.of(context).addNewTweet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
