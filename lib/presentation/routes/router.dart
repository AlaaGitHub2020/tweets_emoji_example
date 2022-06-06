import 'package:auto_route/annotations.dart';
import 'package:tweets_emoji_example/presentation/add_new_tweet/add_new_tweet_page.dart';
import 'package:tweets_emoji_example/presentation/firebase_version/firebase_version_page.dart';
import 'package:tweets_emoji_example/presentation/home/home_page.dart';
import 'package:tweets_emoji_example/presentation/sql_lite_version/sql_lite_version_page.dart';

@MaterialAutoRouter(
  preferRelativeImports: true,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: FirebaseVersionPage),
    AutoRoute(page: SQLLiteVersionPage),
    AutoRoute(page: AddNewTweetPage),
  ],
)
class $AppRouter {}
