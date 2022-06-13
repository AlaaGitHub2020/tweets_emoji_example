part of 'tweet_actor_bloc.dart';

@freezed
abstract class TweetActorEvent with _$TweetActorEvent {
  const factory TweetActorEvent.deleted(Tweet tweet) = _Deleted;

  const factory TweetActorEvent.deletedFromSQL(Tweet tweet) = _DeletedFromSQL;

  const factory TweetActorEvent.update(Tweet tweet) = _Update;

  const factory TweetActorEvent.updateFromSQL(Tweet tweet) = _UpdateFromSQL;
}
