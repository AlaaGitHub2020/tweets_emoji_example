import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sql_tweet_watcher_state.dart';

class SqlTweetWatcherCubit extends Cubit<SqlTweetWatcherState> {
  SqlTweetWatcherCubit() : super(SqlInit());

  void updatingSQL() async {
    emit(SqlDatabaseLoading());
    await Future.delayed(const Duration(seconds: 2))
        .then((value) => emit(SqlDatabaseLoaded()));
  }

  SqlTweetWatcherState getState() {
    return state;
  }
}
