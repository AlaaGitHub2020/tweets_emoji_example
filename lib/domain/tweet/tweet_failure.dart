import 'package:freezed_annotation/freezed_annotation.dart';

part 'tweet_failure.freezed.dart';

@freezed
abstract class TweetFailure with _$TweetFailure {
  const factory TweetFailure.unexpected() = _Unexpected;

  const factory TweetFailure.platFormServerFailure() = _PlatFormServerFailure;

  const factory TweetFailure.unableToUpdate() = _UnableToUpdate;
}
