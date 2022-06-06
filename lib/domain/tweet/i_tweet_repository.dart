import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';

abstract class ITweetRepository {
  Stream<Either<TweetFailure, KtList<Tweet>>> watchAll();

  Future<Either<TweetFailure, Unit>> create(Tweet tweet);

  Future<Either<TweetFailure, Unit>> update(Tweet tweet);

  Future<Either<TweetFailure, Unit>> delete(Tweet tweet);
}
