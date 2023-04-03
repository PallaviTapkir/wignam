import 'dart:developer';

import 'package:flutter/material.dart';

class HomeViewController extends ChangeNotifier {
  bool get isLoading => isLoadingNotifier.value;
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  void _refresh() => notifyListeners();

  void startLoading() {
    if (!isLoadingNotifier.value) {
      isLoadingNotifier.value = true;
      _refresh();
      log('Loading started');
    } else {
      log('Already loading');
    }
  }

  void stopLoading() {
    if (isLoadingNotifier.value) {
      isLoadingNotifier.value = false;
      _refresh();
      log('Loading stopped');
    } else {
      log('Not loading');
    }
  }
}
