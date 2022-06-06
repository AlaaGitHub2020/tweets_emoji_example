import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/presentation/routes/router.gr.dart';

class TryWithFirebaseBtn extends StatelessWidget {
  const TryWithFirebaseBtn({Key? key}) : super(key: key);

  onPressedTryWithFirebase(BuildContext context) {
    final log = getLogger();
    log.i("onPressedTryWithFirebase Started");
    context.router.push(const FirebaseVersionRoute());
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressedTryWithFirebase(context),
        child: Text(S.of(context).tryWithFirebase));
  }
}
