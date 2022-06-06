import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tweets_emoji_example/domain/utils/colors.dart';
import 'package:tweets_emoji_example/generated/l10n.dart';

Config buildEmojiConfig() {
  return Config(
      columns: 7,
      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
      verticalSpacing: 0,
      horizontalSpacing: 0,
      initCategory: Category.RECENT,
      bgColor: AppColors.whiteColor1,
      indicatorColor: AppColors.primaryColor,
      iconColor: AppColors.grayColor1,
      iconColorSelected: AppColors.primaryColor,
      progressIndicatorColor: AppColors.primaryColor,
      backspaceColor: AppColors.primaryColor,
      skinToneDialogBgColor: AppColors.whiteColor1,
      skinToneIndicatorColor: AppColors.grayColor1,
      enableSkinTones: true,
      showRecentsTab: true,
      recentsLimit: 28,
      noRecents: Text(
        S.current.noRecent,
        style: TextStyle(fontSize: 20, color: AppColors.blackColor1),
        textAlign: TextAlign.center,
      ),
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL);
}
