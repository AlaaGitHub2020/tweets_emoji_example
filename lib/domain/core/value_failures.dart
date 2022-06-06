import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_value_failure.dart';

part 'value_failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.tweet(TweetValueFailure<T> failure) = _Tweet<T>;
}
