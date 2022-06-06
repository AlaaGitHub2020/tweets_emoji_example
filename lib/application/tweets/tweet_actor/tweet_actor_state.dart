part of 'tweet_actor_bloc.dart';

@freezed
abstract class TweetActorState with _$TweetActorState {
  const factory TweetActorState.initial() = _Initial;

  const factory TweetActorState.actionInProgress() = _ActionInProgress;

  const factory TweetActorState.deleteFailure(TweetFailure tweetFailure) =
      _DeleteFailure;

  const factory TweetActorState.deleteSuccess() = _DeleteSuccess;

  const factory TweetActorState.updateFailure(TweetFailure tweetFailure) =
      _UpdateFailure;

  const factory TweetActorState.updateSuccess() = _UpdateSuccess;
}
