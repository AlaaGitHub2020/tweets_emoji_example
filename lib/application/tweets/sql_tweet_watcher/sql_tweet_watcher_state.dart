part of 'sql_tweet_watcher_cubit.dart';

@immutable
abstract class SqlTweetWatcherState {}

class SqlInit extends SqlTweetWatcherState {}

class SqlDatabaseLoading extends SqlTweetWatcherState {}

class SqlDatabaseLoaded extends SqlTweetWatcherState {}
