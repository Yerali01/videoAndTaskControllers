import 'package:flutter/material.dart';
import 'package:trimming_video/core/theme/app_pallete.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: AppPallete.greyColor,
        showCloseIcon: true,
      ),
    );
}
