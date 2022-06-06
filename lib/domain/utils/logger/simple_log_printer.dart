import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:tweets_emoji_example/domain/utils/logger/stack_trace_fromatter.dart';

Logger getLogger() {
  return Logger(
    printer: SimpleLogPrinter(),
  );
}

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter();

  @override
  List<String> log(LogEvent event) {
    try {
      var color = PrettyPrinter.levelColors[event.level];
      var emoji = PrettyPrinter.levelEmojis[event.level];

      String method =
          StackTraceFormatter.formatStackTrace(StackTrace.current, 2, 1)!;
      if (kDebugMode) {
        print(color!("$emoji | $method | ${event.message}"));
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
