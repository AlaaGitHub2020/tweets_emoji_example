part of 'tweet_watcher_bloc.dart';

@freezed
abstract class TweetWatcherState with _$TweetWatcherState {
  const factory TweetWatcherState.initial() = _Initial;

  const factory TweetWatcherState.loadInProgress() = _LoadInProgress;

  const factory TweetWatcherState.loadSuccess(KtList<Tweet> tweets) =
      _LoadSuccess;

  const factory TweetWatcherState.loadFailure(TweetFailure tweetFailure) =
      _LoadFailure;
}
