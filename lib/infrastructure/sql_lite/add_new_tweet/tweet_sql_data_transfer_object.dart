import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';

part 'tweet_sql_data_transfer_object.freezed.dart';
part 'tweet_sql_data_transfer_object.g.dart';

///Dto: data transfer object
@freezed
abstract class TweetSQLDto with _$TweetSQLDto {
  factory TweetSQLDto({
    @JsonKey(ignore: true) String? id,
    required String tweetBody,
    required String tweetEmoji,
    required String hasEmoji,
  }) = _TweetSQLDto;

  factory TweetSQLDto.fromDomain(Tweet tweet) {
    return TweetSQLDto(
      id: tweet.id.getOrCrash(),
      tweetBody: tweet.tweetBody.getOrCrash(),
      tweetEmoji: tweet.tweetEmoji.getOrCrash(),
      hasEmoji: tweet.hasEmoji.toString(),
    );
  }
  factory TweetSQLDto.fromDomainToObject(TweetSQLDto tweet) {
    return TweetSQLDto(
      id: tweet.id,
      tweetBody: tweet.tweetBody,
      tweetEmoji: tweet.tweetEmoji,
      hasEmoji: tweet.hasEmoji.toString(),
    );
  }

  factory TweetSQLDto.fromJson(Map<String, dynamic> json) =>
      _$TweetSQLDtoFromJson(json);

  factory TweetSQLDto.fromDatabase(Map<String, Object?> doc) {
    return TweetSQLDto.fromJson(doc).copyWith(
      id: doc.entries.firstWhere((entry) => entry.key == 'id').value.toString(),
    );
  }
}

extension TweetSQLDtoX on TweetSQLDto {
  Tweet toDomain() {
    return Tweet(
      id: UniqueId(),
      tweetBody: TweetBody(tweetBody),
      tweetEmoji: TweetEmoji(tweetEmoji),
      hasEmoji: hasEmoji.toLowerCase() == "true" ? true : false,
    );
  }
}
