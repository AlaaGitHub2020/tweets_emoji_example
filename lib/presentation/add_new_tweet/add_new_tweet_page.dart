import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweets_emoji_example/application/tweets/tweet_form/tweet_form_bloc.dart';
import 'package:tweets_emoji_example/domain/tweet/tweet.dart';
import 'package:tweets_emoji_example/domain/utils/colors.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';
import 'package:tweets_emoji_example/injection.dart';
import 'package:tweets_emoji_example/presentation/add_new_tweet/widgets/add_new_tweet_body.dart';
import 'package:tweets_emoji_example/presentation/core/loading.dart';
import 'package:tweets_emoji_example/presentation/core/snackbars.dart';
import 'package:tweets_emoji_example/presentation/routes/router.gr.dart';

class AddNewTweetPage extends StatelessWidget {
  final Tweet? editedTweet;
  final bool fromSQL;

  const AddNewTweetPage({Key? key, this.editedTweet, required this.fromSQL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TweetFormBloc>(
          create: (context) => getIt<TweetFormBloc>(),
        ),
      ],
      child: BlocConsumer<TweetFormBloc, TweetFormState>(
        listenWhen: (previousState, currentState) =>
            previousState.saveFailureOrSuccessOption !=
            currentState.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () => null,
            (either) => either.fold(
              (failure) => SnackBars.showError(
                context,
                failure.map(
                    unexpected: (_) => S.of(context).unexpected,
                    platFormServerFailure: (_) =>
                        S.of(context).platFormServerFailure,
                    unableToUpdate: (_) => S.of(context).unableToUpdate,
                    platFormSQLDataBaseFailure: (_) =>
                        S.of(context).platFormSQLDataBaseFailure),
              ),
              (_) {
                context.router
                    .popUntil((route) => route.settings.name == HomeRoute.name);
              },
            ),
          );
        },
        buildWhen: (previousState, currentState) =>
            previousState.isSaving != currentState.isSaving,
        builder: (context, state) {
          return Stack(
            children: [
              ThePage(fromSQL: fromSQL),
              SavingInProgressOverlay(isSaving: state.isSaving),
            ],
          );
        },
      ),
    );
  }
}

class ThePage extends StatelessWidget {
  final bool fromSQL;

  const ThePage({Key? key, required this.fromSQL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: BlocBuilder<TweetFormBloc, TweetFormState>(
          buildWhen: (previousState, currentState) =>
              previousState.isEditing != currentState.isEditing,
          builder: (context, state) {
            return Text(state.isEditing
                ? S.of(context).editTweet
                : S.of(context).createANewTweet);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (fromSQL) {
                context
                    .read<TweetFormBloc>()
                    .add(const TweetFormEvent.savedWithSQL());
              } else {
                context.read<TweetFormBloc>().add(const TweetFormEvent.saved());
              }
            },
          ),
        ],
      ),
      body: const AddNewTweetBody(),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSaving ? const Loading() : Container(),
              const SizedBox(height: 10),
              Text(
                S.of(context).saving,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: AppColors.whiteColor1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
