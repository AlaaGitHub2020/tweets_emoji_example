import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tweets_emoji_example/domain/tweet/i_tweet_repository.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/infrastructure/firrebase/add_new_tweet/tweet_data_transfer_object.dart';
import 'package:tweets_emoji_example/infrastructure/firrebase/core/firestore_helpers.dart';

@LazySingleton(as: ITweetRepository)
class FirestoreTweetRepository implements ITweetRepository {
  final FirebaseFirestore _firebaseFirestore;

  final log = getLogger();

  FirestoreTweetRepository(this._firebaseFirestore);

  @override
  Stream<Either<TweetFailure, KtList<Tweet>>> watchAll() async* {
    final tweetDocumentReference =
        await _firebaseFirestore.tweetDocumentReference();
    final tweetQuerySnapshot = await _firebaseFirestore.tweetQuerySnapshot();
    List<Tweet> tweetsList = [];
    for (var element in tweetQuerySnapshot.docs) {
      Tweet tweet = TweetDto.fromFirestore(element).toDomain();
      tweetsList.add(tweet);
    }

    yield* tweetDocumentReference.snapshots().map((snapshot) {
      return right<TweetFailure, KtList<Tweet>>(tweetsList.toImmutableList());
    }).onErrorReturnWith((error, stackTrace) {
      log.e("ERROR :$error");
      log.e("stackTrace :$stackTrace");
      if (error is FirebaseException) {
        return left(const TweetFailure.platFormServerFailure());
      } else {
        return left(const TweetFailure.unexpected());
      }
    });
  }

  @override
  Future<Either<TweetFailure, Unit>> create(Tweet tweet) async {
    try {
      final tweetDoc = await _firebaseFirestore.tweetDocumentReference();
      final tweetDto = TweetDto.fromDomain(tweet);
      await tweetDoc.set(tweetDto.toJson());

      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      if (error is FirebaseException) {
        return left(const TweetFailure.platFormServerFailure());
      } else {
        return left(const TweetFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<TweetFailure, Unit>> update(Tweet tweet) async {
    try {
      final tweetDoc =
          await _firebaseFirestore.tweetDocumentReferenceById(tweet);
      final tweetDto = TweetDto.fromDomain(tweet);
      await tweetDoc.update(tweetDto.toJson());

      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");

      if (error.message!.contains("NOT_FOUND")) {
        return left(const TweetFailure.unableToUpdate());
      } else if (error is FirebaseException) {
        return left(const TweetFailure.platFormServerFailure());
      } else {
        return left(const TweetFailure.unexpected());
      }
    } catch (e) {
      log.e("ERROR :$e");
      return left(const TweetFailure.unexpected());
    }
  }

  @override
  Future<Either<TweetFailure, Unit>> delete(Tweet tweet) async {
    try {
      final tweetDoc =
          await _firebaseFirestore.tweetDocumentReferenceById(tweet);
      await tweetDoc.delete();

      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      if (error is FirebaseException) {
        return left(const TweetFailure.platFormServerFailure());
      }
      if (error.message!.contains("NOT_FOUND")) {
        return left(const TweetFailure.unableToUpdate());
      } else {
        return left(const TweetFailure.unexpected());
      }
    }
  }
}
