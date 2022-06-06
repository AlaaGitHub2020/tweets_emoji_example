import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';

part 'tweet_data_transfer_object.freezed.dart';
part 'tweet_data_transfer_object.g.dart';

///Dto: data transfer object
@freezed
abstract class TweetDto with _$TweetDto {
  factory TweetDto({
    @JsonKey(ignore: true) String? id,
    required String tweetBody,
    required String tweetEmoji,
    required bool hasEmoji,
    @ServerTimestampConverter() required FieldValue serverTimeStamp,
  }) = _TweetDto;

  factory TweetDto.fromDomain(Tweet tweet) {
    return TweetDto(
      id: tweet.id.getOrCrash(),
      tweetBody: tweet.tweetBody.getOrCrash(),
      tweetEmoji: tweet.tweetEmoji.getOrCrash(),
      hasEmoji: tweet.hasEmoji,
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory TweetDto.fromJson(Map<String, dynamic> json) =>
      _$TweetDtoFromJson(json);

  factory TweetDto.fromFirestore(DocumentSnapshot doc) {
    final log = getLogger();
    log.i(doc.data());
    Map<String, dynamic> jsonFromFirestoreObject =
        doc.data() as Map<String, dynamic>;
    return TweetDto.fromJson(jsonFromFirestoreObject).copyWith(id: doc.id);
  }
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}

extension TweetDtoX on TweetDto {
  Tweet toDomain() {
    return Tweet(
      id: UniqueId.fromUniqueString(id!),
      tweetBody: TweetBody(tweetBody),
      tweetEmoji: TweetEmoji(tweetEmoji),
      hasEmoji: hasEmoji,
    );
  }
}
