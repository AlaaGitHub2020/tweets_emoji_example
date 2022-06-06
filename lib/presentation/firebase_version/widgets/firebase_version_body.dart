import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_watcher/tweet_watcher_bloc.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';
import 'package:tweets_emoji_example/domain/utils/colors.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/presentation/core/loading.dart';
import 'package:tweets_emoji_example/presentation/firebase_version/widgets/tweet_with_emoji.dart';

class FirebaseVersionBody extends StatelessWidget {
  const FirebaseVersionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetWatcherBloc, TweetWatcherState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.map(
            initial: (_) => Container(),
            loadInProgress: (_) => const Loading(),
            loadSuccess: (state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "${S.of(context).theSizeOfDatabase} ${state.tweets.size}",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 8),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.tweets.size,
                      itemBuilder: (context, index) {
                        final tweet = state.tweets[index];
                        if (tweet.failureOption.isSome()) {
                          return Text(
                            "${tweet.failureOption}",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: AppColors.errorColor),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TweetWithEmoji(tweet: tweet),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
            loadFailure: (state) {
              if (state.tweetFailure == const TweetFailure.unexpected()) {
                return const Loading();
              } else {
                return Text(
                  S.of(context).weHaveAnError,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: AppColors.errorColor),
                );
              }
            });
      },
    );
  }
}
