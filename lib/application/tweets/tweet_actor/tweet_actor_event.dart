part of 'tweet_actor_bloc.dart';

@freezed
abstract class TweetActorEvent with _$TweetActorEvent {
  const factory TweetActorEvent.deleted(Tweet tweet) = _Deleted;

  const factory TweetActorEvent.update(Tweet tweet) = _Update;
}
