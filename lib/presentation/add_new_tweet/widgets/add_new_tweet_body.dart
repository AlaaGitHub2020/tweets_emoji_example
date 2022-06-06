import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_form/tweet_form_bloc.dart';
import 'package:tweets_emoji_example/presentation/add_new_tweet/widgets/add_emoji_widget.dart';
import 'package:tweets_emoji_example/presentation/add_new_tweet/widgets/tweet_body_field_widget.dart';

class AddNewTweetBody extends StatelessWidget {
  const AddNewTweetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetFormBloc, TweetFormState>(
      buildWhen: (previousState, currentState) =>
          previousState.showErrorMessages != currentState.showErrorMessages,
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages,
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: state.showErrorMessages,
              child: Column(
                children: const [
                  TweetBodyField(),
                  AddEmoji(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
