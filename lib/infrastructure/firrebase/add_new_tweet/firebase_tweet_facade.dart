import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tweets_emoji_example/domain/tweet/i_tweet_facade.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';

@LazySingleton(as: ITweetFacade)
class FirebaseTweetFacade implements ITweetFacade {
  final log = getLogger();

  FirebaseTweetFacade();

  @override
  Future<Option<UniqueId>> getTweetId({required Tweet tweet}) async {
    if (tweet.id != null) {
      return optionOf(tweet.id);
    }
    return none();
  }
}
