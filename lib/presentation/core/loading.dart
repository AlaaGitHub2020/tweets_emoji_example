import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/domain/utils/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.greenColor1,
      ),
    );
  }
}
