part of 'tweet_watcher_bloc.dart';

@freezed
abstract class TweetWatcherEvent with _$TweetWatcherEvent {
  const factory TweetWatcherEvent.watchAllStarted() = _WatchAllStarted;

  const factory TweetWatcherEvent.tweetsReceived(
      Either<TweetFailure, KtList<Tweet>> failureOrTweets) = _TweetsReceived;
}
