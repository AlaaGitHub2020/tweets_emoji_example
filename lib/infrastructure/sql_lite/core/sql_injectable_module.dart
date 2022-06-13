import 'package:injectable/injectable.dart';
import 'package:tweets_emoji_example/infrastructure/sql_lite/core/database_helper.dart';

@module
abstract class SQLLInjectableModule {
  @lazySingleton
  DatabaseHelper get sqlDatabase => DatabaseHelper.instance;
}
