import 'package:dartz/dartz.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';

abstract class ITweetFacade {
  Future<Option<UniqueId>> getTweetId({required Tweet tweet});
}
