import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/domain/utils/strings.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/add_new_tweet/tweet_sql_data_transfer_object.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  final log = getLogger();

  static Database? _database;

  @lazySingleton
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, Strings.cDatabaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    try {
      log.i("_onCreate Database Started");
      await db.execute('''
        create table ${Strings.cDatabaseTableName} ( 
  ${Strings.cDatabaseTweetId} integer primary key, 
  ${Strings.cDatabaseTweetBody} text not null,
  ${Strings.cDatabaseTweetEmoji} text not null,
  ${Strings.cDatabaseHasEmoji} text not null
  )
    ''');
    } catch (e) {
      log.e("ERROR With Creating the database :$e");
    }
  }

  Future<List<TweetSQLDto>?> getTweets() async {
    try {
      Database db = await instance.database;
      var tweets = await db.query(Strings.cDatabaseTableName,
          orderBy: Strings.cDatabaseTweetId);
      List<TweetSQLDto> tweetList = tweets.isNotEmpty
          ? tweets.map((tweet) {
              return TweetSQLDto.fromDatabase(tweet);
            }).toList()
          : [];
      return tweetList;
    } catch (e) {
      log.e("ERROR With getTweets from database :$e");
      return null;
    }
  }

  Future<int?> getDatabaseSizeCount() async {
    try {
      Database db = await database;
      var databaseSize = await db
          .rawQuery('SELECT COUNT (*) from ${Strings.cDatabaseTableName}');
      int? databaseSizeCount = Sqflite.firstIntValue(databaseSize);
      return databaseSizeCount;
    } catch (e) {
      log.e("ERROR With getDatabaseSizeCount from database :$e");
      return null;
    }
  }
}
