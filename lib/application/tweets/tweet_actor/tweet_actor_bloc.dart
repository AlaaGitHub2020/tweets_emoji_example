import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tweets_emoji_example/domain/tweet/i_sql_tweet_repository.dart';
import 'package:tweets_emoji_example/domain/tweet/i_tweet_repository.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/add_new_tweet/tweet_sql_data_transfer_object.dart';

part 'tweet_actor_bloc.freezed.dart';
part 'tweet_actor_event.dart';
part 'tweet_actor_state.dart';

@injectable
class TweetActorBloc extends Bloc<TweetActorEvent, TweetActorState> {
  final ITweetRepository _tweetRepository;
  final ISQLTweetRepository _sQLTweetRepository;
  final log = getLogger();

  TweetActorBloc(this._tweetRepository, this._sQLTweetRepository)
      : super(const TweetActorState.initial()) {
    on<TweetActorEvent>(
      (event, emit) async {
        await event.map(
          deleted: (e) async {
            log.i("deleted started");
            emit(const TweetActorState.actionInProgress());
            final possibleFailure = await _tweetRepository.delete(event.tweet);
            emit(
              possibleFailure.fold(
                (failure) => TweetActorState.deleteFailure(failure),
                (_) => const TweetActorState.deleteSuccess(),
              ),
            );
          },
          update: (e) async {
            log.i("update started");
            emit(const TweetActorState.actionInProgress());
            final possibleFailure = await _tweetRepository.update(event.tweet);
            emit(
              possibleFailure.fold(
                (failure) => TweetActorState.updateFailure(failure),
                (_) => const TweetActorState.updateSuccess(),
              ),
            );
          },
          deletedFromSQL: (e) async {
            log.i("deletedFromSQL started");
            emit(const TweetActorState.actionInProgress());
            final possibleFailure =
                await _sQLTweetRepository.delete(event.tweet);
            emit(
              possibleFailure.fold(
                (failure) => TweetActorState.deleteFailure(failure),
                (_) => const TweetActorState.deleteSuccess(),
              ),
            );
          },
          updateFromSQL: (e) async {
            log.i("updateFromSQL started");
            emit(const TweetActorState.actionInProgress());
            final possibleFailure =
                await _sQLTweetRepository.update(event.tweet);
            emit(
              possibleFailure.fold(
                (failure) => TweetActorState.updateFailure(failure),
                (_) => const TweetActorState.updateSuccess(),
              ),
            );
          },
        );
      },
    );
  }
}
