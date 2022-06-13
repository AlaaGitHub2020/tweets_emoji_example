import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tweets_emoji_example/application/tweets/sql_tweet_watcher/sql_tweet_watcher_cubit.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_actor/tweet_actor_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_watcher/tweet_watcher_bloc.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';
import 'package:tweets_emoji_example/domain/utils/colors.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/presentation/core/emoji_config_widget.dart';

class TweetWithEmoji extends HookWidget {
  final Tweet? tweet;
  final bool fromSQL;

  const TweetWithEmoji({
    Key? key,
    this.tweet,
    this.fromSQL = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showEmoji = useState(false);

    var theEmoji =
        useState(tweet!.hasEmoji ? tweet!.tweetEmoji.getOrCrash() : "");

    _onEmojiSelected(Emoji emoji) {
      theEmoji.value = emoji.emoji;
      showEmoji.value = !showEmoji.value;
      if (tweet != null) {
        if (fromSQL) {
          context
              .read<TweetActorBloc>()
              .add(TweetActorEvent.updateFromSQL(tweet!.copyWith(
                tweetEmoji: TweetEmoji(theEmoji.value),
              )));
        } else {
          context
              .read<TweetActorBloc>()
              .add(TweetActorEvent.update(tweet!.copyWith(
                tweetEmoji: TweetEmoji(theEmoji.value),
              )));
        }
      }
    }

    _onBackspacePressed() {}

    return Column(
      children: [
        GestureDetector(
          onLongPress: () {
            final log = getLogger();
            log.i("Delete tweet Started");
            if (tweet != null) {
              if (fromSQL) {
                context
                    .read<TweetActorBloc>()
                    .add(TweetActorEvent.deletedFromSQL(tweet!));
                context.read<SqlTweetWatcherCubit>().updatingSQL();
              } else {
                context
                    .read<TweetActorBloc>()
                    .add(TweetActorEvent.deleted(tweet!));
                context
                    .read<TweetWatcherBloc>()
                    .add(const TweetWatcherEvent.watchAllStarted());
              }
            }
          },
          child: Stack(
            children: [
              buildTweet(context, showEmoji),
              showEmoji.value ? Container() : buildSelectedEmoji(theEmoji),
            ],
          ),
        ),
        buildEmojiPicker(showEmoji, _onEmojiSelected, _onBackspacePressed),
      ],
    );
  }

  Container buildTweet(BuildContext context, ValueNotifier<bool> showEmoji) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: AppColors.primaryColor.withOpacity(0.6),
      ),
      child: ListTile(
        style: ListTileStyle.drawer,
        onTap: () {
          showEmoji.value = !showEmoji.value;
        },
        title: Text(
          tweet!.tweetBody.getOrCrash(),
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: AppColors.whiteColor1),
        ),
      ),
    );
  }

  Positioned buildSelectedEmoji(ValueNotifier<String> theEmoji) {
    return Positioned(
      bottom: 10,
      right: 20,
      child: Text(
        theEmoji.value,
        style: const TextStyle(fontSize: 25),
      ),
    );
  }

  Offstage buildEmojiPicker(
      ValueNotifier<bool> showEmoji,
      Null Function(Emoji emoji) onEmojiSelected,
      Null Function() onBackspacePressed) {
    return Offstage(
      offstage: !showEmoji.value,
      child: SizedBox(
        height: 100,
        child: EmojiPicker(
          onEmojiSelected: (Category category, Emoji emoji) {
            onEmojiSelected(emoji);
          },
          onBackspacePressed: onBackspacePressed,
          config: buildEmojiConfig(),
        ),
      ),
    );
  }
}
