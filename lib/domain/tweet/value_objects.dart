import 'package:dartz/dartz.dart';
import 'package:tweets_emoji_example/domain/core/value_failures.dart';
import 'package:tweets_emoji_example/domain/core/value_objects.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_value_validators.dart';
import 'package:uuid/uuid.dart';

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(
      right(
        const Uuid().v1(),
      ),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      right(uniqueId),
    );
  }

  const UniqueId._(this.value);
}

class TweetBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 1000;

  factory TweetBody(String input) {
    return TweetBody._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  const TweetBody._(this.value);
}

class TweetEmoji extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 30;

  factory TweetEmoji(String input) {
    return TweetEmoji._(
      validateMaxStringLength(input, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }

  const TweetEmoji._(this.value);
}
