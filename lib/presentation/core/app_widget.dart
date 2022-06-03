import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/presentation/routes/router.gr.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweetsEmoji();
  }
}

class TweetsEmoji extends StatefulWidget {
  const TweetsEmoji({Key? key}) : super(key: key);

  @override
  State<TweetsEmoji> createState() => _TweetsEmojiState();
}

class _TweetsEmojiState extends State<TweetsEmoji> {
  Locale? _locale;

  final _appRouter = AppRouter();

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Tweets Emoji',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const HomePage(title: 'Tweets Emoji'),
    // );
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        // locale: kReleaseMode ? _locale : DevicePreview.locale(context),
        locale: _locale,
        // title: Strings.appTitle,
        title: 'Tweets Emoji',
        // theme: context.watch<ThemeCubit>().state.theme,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return locale;
            }
          }
          return null;
        },
      );
    });
  }
}
