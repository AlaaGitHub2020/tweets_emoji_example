import 'package:dartz/dartz.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';

abstract class ISQLTweetRepository {
  Future<Either<TweetFailure, Unit>> create(Tweet tweet);

  Future<Either<TweetFailure, Unit>> update(Tweet tweet);

  Future<Either<TweetFailure, Unit>> delete(Tweet tweet);
}
