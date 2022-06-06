import 'package:tweets_emoji_example/domain/core/value_failures.dart';

class NoTweetFileError extends Error {}

class UnexpectedValueErrors extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueErrors(this.valueFailure);

  @override
  String toString() {
    const String explanation =
        'Encountered a ValueFailure at an unrecoverable point. Termination.';
    return Error.safeToString("$explanation Failure was: $valueFailure");
  }
}
