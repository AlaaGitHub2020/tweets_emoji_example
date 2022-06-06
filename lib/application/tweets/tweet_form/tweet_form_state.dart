part of 'tweet_form_bloc.dart';

@freezed
abstract class TweetFormState with _$TweetFormState {
  const factory TweetFormState({
    required Tweet tweet,
    required AutovalidateMode showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<TweetFailure, Unit>> saveFailureOrSuccessOption,
  }) = _TweetFormState;

  factory TweetFormState.initial() => TweetFormState(
        tweet: Tweet.empty(),
        showErrorMessages: AutovalidateMode.disabled,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );
}
