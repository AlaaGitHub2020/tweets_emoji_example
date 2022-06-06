part of 'tweet_form_bloc.dart';

@freezed
abstract class TweetFormEvent with _$TweetFormEvent {
  const factory TweetFormEvent.initialized(Option<Tweet> initialTweetOption) =
      _Initialized;

  const factory TweetFormEvent.tweetBodyChanged(String tweetBodyStr) =
      _TweetBodyChanged;
  const factory TweetFormEvent.tweetEmojiChanged(String tweetEmojiStr) =
      _TweetEmojiChanged;

  const factory TweetFormEvent.hasEmojiChanged(bool hasEmoji) =
      _HasEmojiChanged;

  const factory TweetFormEvent.saved() = _Saved;
}
