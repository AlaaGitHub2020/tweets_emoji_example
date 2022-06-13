import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tweets_emoji_example/domain/tweet/i_sql_tweet_repository.dart';
import 'package:tweets_emoji_example/domain/tweet/i_tweet_repository.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';

part 'tweet_form_bloc.freezed.dart';
part 'tweet_form_event.dart';
part 'tweet_form_state.dart';

@injectable
class TweetFormBloc extends Bloc<TweetFormEvent, TweetFormState> {
  final ITweetRepository _tweetRepository;
  final ISQLTweetRepository _sQLTweetRepository;
  final log = getLogger();

  TweetFormBloc(this._tweetRepository, this._sQLTweetRepository)
      : super(TweetFormState.initial()) {
    on<TweetFormEvent>(
      (event, emit) async {
        await event.map(
          initialized: (e) async {
            log.i("initialized started");
            emit(e.initialTweetOption.fold(
                () => state,
                (initialWord) => state.copyWith(
                      tweet: initialWord,
                      isEditing: true,
                    )));
          },
          tweetBodyChanged: (e) async {
            log.i("tweetBodyChanged started");
            emit(
              state.copyWith(
                tweet:
                    state.tweet.copyWith(tweetBody: TweetBody(e.tweetBodyStr)),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          tweetEmojiChanged: (e) async {
            log.i("tweetEmojiChanged started");
            emit(
              state.copyWith(
                tweet: state.tweet
                    .copyWith(tweetEmoji: TweetEmoji(e.tweetEmojiStr)),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          hasEmojiChanged: (e) async {
            log.i("hasEmojiChanged started");
            emit(
              state.copyWith(
                tweet: state.tweet.copyWith(hasEmoji: e.hasEmoji),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          saved: (e) async {
            log.i("saved started");
            TweetFormState tweetFormState = state.isEditing
                ? await _performActionOnTweetRepository(
                    forwardedCall: _tweetRepository.update(state.tweet),
                  )
                : await _performActionOnTweetRepository(
                    forwardedCall: _tweetRepository.create(state.tweet),
                  );
            emit(tweetFormState);
          },
          savedWithSQL: (e) async {
            log.i("savedWithSQL started");
            TweetFormState tweetFormState = state.isEditing
                ? await _performActionOnTweetRepository(
                    forwardedCall: _sQLTweetRepository.update(state.tweet),
                  )
                : await _performActionOnTweetRepository(
                    forwardedCall: _sQLTweetRepository.create(state.tweet),
                  );
            emit(tweetFormState);
          },
        );
      },
    );
  }

  _performActionOnTweetRepository(
      {required Future<Either<TweetFailure, Unit>> forwardedCall}) async {
    log.i("_performActionOnTweetRepository started");
    Either<TweetFailure, Unit> failureOrSuccess;
    final bool isTweetBodyValid = state.tweet.tweetBody.isValid();
    final bool isTweetEmojiValid = state.tweet.tweetEmoji.isValid();
    final bool hasEmojiValid = state.tweet.hasEmoji;

    if (isTweetBodyValid && isTweetEmojiValid && hasEmojiValid) {
      TweetFormState tweetFormState = state.copyWith(
        isSaving: true,
        saveFailureOrSuccessOption: none(),
      );
      emit(tweetFormState);
    }
    failureOrSuccess = await forwardedCall;
    TweetFormState tweetFormState = state.copyWith(
      isSaving: false,
      showErrorMessages: AutovalidateMode.always,
      saveFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
    return (tweetFormState);
  }
}
