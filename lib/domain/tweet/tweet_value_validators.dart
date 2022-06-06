import 'package:dartz/dartz.dart';
import 'package:tweets_emoji_example/domain/core/value_failures.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_value_failure.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
    String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.tweet(
        TweetValueFailure.exceedingLength(
          failedValue: input,
          max: maxLength,
        ),
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(
      ValueFailure.tweet(
        TweetValueFailure.empty(failedValue: input),
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains("\n")) {
    return left(
      ValueFailure.tweet(
        TweetValueFailure.singleLine(
          failedValue: input,
        ),
      ),
    );
  } else {
    return right(input);
  }
}
