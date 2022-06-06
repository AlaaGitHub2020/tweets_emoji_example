import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_form/tweet_form_bloc.dart';
import 'package:tweets_emoji_example/domain/utils/colors.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/presentation/core/emoji_config_widget.dart';

class AddEmoji extends StatefulWidget {
  const AddEmoji({Key? key}) : super(key: key);

  @override
  State<AddEmoji> createState() => _AddEmojiState();
}

class _AddEmojiState extends State<AddEmoji> {
  String theEmoji = "";
  bool showEmoji = false;
  final log = getLogger();

  _onBackspacePressed() {}

  onTapEmojiBtn(BuildContext context) {
    log.i("onTapEmojiBtn Started");
    TweetFormState tweetFormState = context.read<TweetFormBloc>().state;
    if (tweetFormState.tweet.hasEmoji) {
      setState(() {
        showEmoji = false;
      });

      context
          .read<TweetFormBloc>()
          .add(const TweetFormEvent.hasEmojiChanged(false));
      context
          .read<TweetFormBloc>()
          .add(const TweetFormEvent.tweetEmojiChanged(""));
    } else {
      setState(() {
        showEmoji = true;
      });
    }
  }

  _onEmojiSelected(Emoji emoji) {
    log.i("_onEmojiSelected Started");
    setState(() {
      theEmoji = emoji.emoji;
      showEmoji = !showEmoji;
    });
    context
        .read<TweetFormBloc>()
        .add(const TweetFormEvent.hasEmojiChanged(true));
    context
        .read<TweetFormBloc>()
        .add(TweetFormEvent.tweetEmojiChanged(theEmoji));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TweetFormBloc, TweetFormState>(
      listenWhen: (previousState, currentState) =>
          previousState.isEditing != currentState.isEditing,
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              title: state.tweet.hasEmoji
                  ? buildRemoveTheEmojiText(context)
                  : buildAddAnEmojiText(context),
              leading: buildIcon(state, context),
              onTap: () => onTapEmojiBtn(context),
            ),
            buildEmojiPicker(),
          ],
        );
      },
    );
  }

  Offstage buildEmojiPicker() {
    return Offstage(
      offstage: !showEmoji,
      child: SizedBox(
        height: 100,
        child: EmojiPicker(
          onEmojiSelected: (Category category, Emoji emoji) {
            _onEmojiSelected(emoji);
          },
          onBackspacePressed: _onBackspacePressed,
          config: buildEmojiConfig(),
        ),
      ),
    );
  }

  Padding buildIcon(TweetFormState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: state.tweet.hasEmoji ? buildTheEmoji() : buildNoEmojiIcon(context),
    );
  }

  Icon buildNoEmojiIcon(BuildContext context) {
    return Icon(
      Icons.emoji_emotions_outlined,
      color: Theme.of(context).iconTheme.color,
    );
  }

  Text buildTheEmoji() {
    return Text(theEmoji);
  }

  Text buildRemoveTheEmojiText(BuildContext context) {
    return Text(
      S.of(context).removeTheEmoji,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            color: AppColors.errorColor,
            fontSize: 18,
          ),
    );
  }

  Text buildAddAnEmojiText(BuildContext context) {
    return Text(
      S.of(context).addAnEmoji,
      style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
    );
  }
}
