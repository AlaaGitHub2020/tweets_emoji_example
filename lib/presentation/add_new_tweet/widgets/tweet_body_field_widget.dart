import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_form/tweet_form_bloc.dart';
import 'package:tweets_emoji_example/domain/tweet/value_objects.dart';
import 'package:tweets_emoji_example/domain/utils/logger/simple_log_printer.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';

class TweetBodyField extends HookWidget {
  const TweetBodyField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return BlocListener<TweetFormBloc, TweetFormState>(
      listenWhen: (previousState, currentState) =>
          previousState.isEditing != currentState.isEditing,
      listener: (context, state) {
        try {
          textEditingController.text = state.tweet.tweetBody.getOrCrash();
        } catch (e) {
          final log = getLogger();
          log.e("ERROR:$e");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: S.of(context).typeANewTweet,
            counterText: "",
          ),
          maxLength: TweetBody.maxLength,
          maxLines: 3,
          minLines: 3,
          onChanged: (value) => context.read<TweetFormBloc>().add(
                TweetFormEvent.tweetBodyChanged(value),
              ),
          validator: (_) =>
              context.read<TweetFormBloc>().state.tweet.tweetBody.value.fold(
                    (failure) => failure.maybeMap(
                      tweet: (value) => value.failure.maybeMap(
                        empty: (_) => S.of(context).canNotBbeEmpty,
                        exceedingLength: (failure) =>
                            "${S.of(context).exceedingLengthMax} ${failure.max} ",
                        orElse: () => null,
                      ),
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        ),
      ),
    );
  }
}
