import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tweets_emoji_example/domain/core/entity.dart';
import 'package:tweets_emoji_example/domain/core/value_failures.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';

part 'tweet.freezed.dart';

@freezed
abstract class Tweet with _$Tweet implements IEntity {
  const factory Tweet({
    required UniqueId id,
    required TweetBody tweetBody,
    required TweetEmoji tweetEmoji,
    required bool hasEmoji,
  }) = _Tweet;

  factory Tweet.empty() => Tweet(
        id: UniqueId(),
        tweetBody: TweetBody(''),
        tweetEmoji: TweetEmoji(''),
        hasEmoji: false,
      );
}

extension TweetX on Tweet {
  Option<ValueFailure<dynamic>> get failureOption {
    return tweetBody.failureOrUnit
        .andThen(tweetEmoji.failureOrUnit)
        .fold((failure) => some(failure), (_) => none());
  }
}
