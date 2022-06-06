import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/presentation/routes/router.gr.dart';

class TryWithSQLLiteBtn extends StatelessWidget {
  const TryWithSQLLiteBtn({Key? key}) : super(key: key);

  onPressedTryWithSQLLite(BuildContext context) {
    final log = getLogger();
    log.i("onPressedTryWithSQLLite Started");
    context.router.push(const SQLLiteVersionRoute());
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressedTryWithSQLLite(context),
        child: Text(S.of(context).tryWithSQLLite));
  }
}
