import 'dart:developer';

import '../util/navigation/router.dart';
import '../value/colors.dart';
import 'package:flutter/material.dart';

import 'soft_button_with_divider.dart';

class CustomShapeBottomSheet {
  static void show({
    required BuildContext context,
    required Widget content,
    String? actionLabel,
    void Function()? onPressed,
    bool isDismissible = true,
    bool showCloseButton = true,
    bool showActionButton = true,
  }) {
    final Widget child = SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Close Button
          if (showCloseButton)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: InkWell(
                  onTap: () {
                    RouteManger.navigateBack(
                        context: context,
                        useContextBasedPop: true,
                        rootNavigator: true);
                  },
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: Container(
                    width: 60.0,
                    height: 42.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            ),
          // Content + Action
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              vertical: 48.0,
            ),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content
                content,
                // Action Button
                if (showActionButton)
                  SoftButtonWithDivider(
                    alignment: Alignment.centerRight,
                    onPressed: onPressed,
                    color: AppColors.secondary,
                    highlightFactor: 0.75,
                    // shadowFactor: 0.25,
                    width: 130.0,
                    height: 36.0,
                    bevel: 6.0,
                    child: Text(
                      actionLabel!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          isDismissible: isDismissible,
          useRootNavigator: true,
          builder: (context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: child,
              )));
    } else {
      try {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            isDismissible: isDismissible,
            useRootNavigator: true,
            builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: child,
                ));
      } catch (e) {
        log('Error in showing dialog: $e');
      }
    }
  }
}
