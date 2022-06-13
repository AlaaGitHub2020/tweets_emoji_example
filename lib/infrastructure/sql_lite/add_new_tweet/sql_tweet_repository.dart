import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tweets_emoji_example/domain/tweet/i_sql_tweet_repository.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet_failure.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/domain/utils/strings.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/add_new_tweet/tweet_sql_data_transfer_object.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/core/database_helper.dart';

@LazySingleton(as: ISQLTweetRepository)
class SQLTweetRepository implements ISQLTweetRepository {
  final DatabaseHelper _databaseHelper;

  final log = getLogger();

  SQLTweetRepository(this._databaseHelper);

  @override
  Future<Either<TweetFailure, Unit>> create(Tweet tweet) async {
    try {
      final tweetDatabase = await _databaseHelper.database;
      final tweetSQLDto = TweetSQLDto.fromDomain(tweet);
      await tweetDatabase.insert(
          Strings.cDatabaseTableName, tweetSQLDto.toJson());

      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      return left(const TweetFailure.platFormSQLDataBaseFailure());
    }
  }

  @override
  Future<Either<TweetFailure, Unit>> update(Tweet tweet) async {
    try {
      final tweetDatabase = await _databaseHelper.database;
      final tweetSQLDto = TweetSQLDto.fromDomain(tweet);
      await tweetDatabase.update(
          Strings.cDatabaseTableName, tweetSQLDto.toJson(),
          where: Strings.cDatabaseWhereConditionWithId,
          whereArgs: [tweetSQLDto.id]);

      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");

      if (error.message!.contains("NOT_FOUND")) {
        return left(const TweetFailure.unableToUpdate());
      } else if (error is DatabaseException) {
        return left(const TweetFailure.platFormSQLDataBaseFailure());
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
      final tweetDatabase = await _databaseHelper.database;
      final tweetSQLDto = TweetSQLDto.fromDomain(tweet);
      await tweetDatabase.delete(Strings.cDatabaseTableName,
          where: Strings.cDatabaseWhereConditionWithId,
          whereArgs: [tweetSQLDto.id]);
      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      if (error is DatabaseException) {
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
