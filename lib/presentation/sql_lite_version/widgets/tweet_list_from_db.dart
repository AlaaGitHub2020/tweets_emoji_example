import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/add_new_tweet/tweet_sql_data_transfer_object.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/core/database_helper.dart';
import 'package:tweets_emoji_example/presentation/core/loading.dart';
import 'package:tweets_emoji_example/presentation/firebase_version/widgets/tweet_with_emoji.dart';
import 'package:tweets_emoji_example/presentation/sql_lite_version/widgets/no_data_in_the_db.dart';

class TweetListFromDB extends StatelessWidget {
  const TweetListFromDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getTweets(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Loading();
        }
        return snapshot.data!.isEmpty
            ? const NoDataInTheDB()
            : buildList(snapshot);
      },
    );
  }

  ListView buildList(AsyncSnapshot<dynamic> snapshot) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        ...snapshot.data!.map(
          (tweetElement) {
            Tweet tweet = Tweet(
                id: UniqueId.fromUniqueString(
                    TweetSQLDto.fromDomainToObject(tweetElement).id.toString()),
                tweetBody: TweetBody(
                    TweetSQLDto.fromDomainToObject(tweetElement).tweetBody),
                hasEmoji:
                    TweetSQLDto.fromDomainToObject(tweetElement).hasEmoji ==
                            "true"
                        ? true
                        : false,
                tweetEmoji: TweetEmoji(
                    TweetSQLDto.fromDomainToObject(tweetElement).tweetEmoji));
            return TweetWithEmoji(tweet: tweet, fromSQL: true);
          },
        ),
      ],
    );
  }
}
