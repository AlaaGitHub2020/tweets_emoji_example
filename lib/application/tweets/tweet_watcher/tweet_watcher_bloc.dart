import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:tweets_emoji_example/domain/tweet/i_tweet_repository.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';

part 'tweet_watcher_bloc.freezed.dart';
part 'tweet_watcher_event.dart';
part 'tweet_watcher_state.dart';

@injectable
class TweetWatcherBloc extends Bloc<TweetWatcherEvent, TweetWatcherState> {
  final ITweetRepository _tweetRepository;
  final log = getLogger();

  late StreamSubscription<Either<TweetFailure, KtList<Tweet>>>
      _tweetStreamSubscription;

  TweetWatcherBloc(this._tweetRepository)
      : super(const TweetWatcherState.initial()) {
    _tweetStreamSubscription = _tweetRepository.watchAll().listen(
          (failureOrTweet) => add(
            TweetWatcherEvent.tweetsReceived(failureOrTweet),
          ),
        );
    on<TweetWatcherEvent>((event, emit) async {
      await event.map(
        watchAllStarted: (e) async {
          log.i("watchAllStarted started");
          emit(const TweetWatcherState.loadInProgress());
          await _tweetStreamSubscription.cancel();
          _tweetStreamSubscription = _tweetRepository.watchAll().listen(
                (failureOrTweet) => add(
                  TweetWatcherEvent.tweetsReceived(failureOrTweet),
                ),
              );
        },
        tweetsReceived: (e) async {
          log.i("tweetsReceived started");
          emit(e.failureOrTweets.fold(
            (failure) => TweetWatcherState.loadFailure(failure),
            (tweets) => TweetWatcherState.loadSuccess(tweets),
          ));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    log.i("close started");
    await _tweetStreamSubscription.cancel();
    return super.close();
  }
}
