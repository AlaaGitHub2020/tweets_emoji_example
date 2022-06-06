import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweets_emoji_example/domain/core/errors.dart';
import 'package:tweets_emoji_example/domain/tweet/i_tweet_facade.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> tweetDocumentReference() async {
    return FirebaseFirestore.instance.collection("tweet").doc();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> tweetQuerySnapshot() async {
    return FirebaseFirestore.instance.collection("tweet").get();
  }

  Future<DocumentReference> tweetDocumentReferenceById(Tweet tweet) async {
    final tweetIdOption = await getIt<ITweetFacade>().getTweetId(tweet: tweet);
    final tweetId = tweetIdOption.getOrElse(
      () => throw NoTweetFileError(),
    );

    return FirebaseFirestore.instance
        .collection("tweet")
        .doc(tweetId.getOrCrash());
  }
}
