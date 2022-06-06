import 'package:freezed_annotation/freezed_annotation.dart';

part 'tweet_value_failure.freezed.dart';

@freezed
abstract class TweetValueFailure<T> with _$TweetValueFailure<T> {
  const factory TweetValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

  const factory TweetValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;

  const factory TweetValueFailure.singleLine({
    required T failedValue,
  }) = SingleLine<T>;
}
