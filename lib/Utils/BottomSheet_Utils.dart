import 'package:flutter/material.dart';

class BottomSheetUtils {

  static void showCustomBottomSheet(BuildContext context, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return content;
      },
    );
  }
}