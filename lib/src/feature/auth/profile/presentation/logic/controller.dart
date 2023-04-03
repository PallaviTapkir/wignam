import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/network_response.dart';
import '../../../../../core/value/strings.dart';
import '../../domain/usecase/submit_user_profile_usecase.dart';

class SubmitUserProfileViewController extends ChangeNotifier {
  SubmitUserProfileViewController({
    required this.submitUserProfileUsecase,
  }) {
    submitUSerProfileFormKey = GlobalKey<FormState>();
    userEmailController = TextEditingController();
    userNameController = TextEditingController();
  }

  final SubmitUserProfileUsecase submitUserProfileUsecase;

  late final GlobalKey<FormState> submitUSerProfileFormKey;
  late final TextEditingController userNameController;
  late final TextEditingController userEmailController;

  bool get isLoading => isLoadingNotifier.value;
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> submitProfileErrorMessage =
      ValueNotifier<String?>(null);

  void _refresh() => notifyListeners();

  String? validateUserNameInput(String? userName) {
    String? message;

    if (userName == null || userName.isEmpty || userName.trim().isEmpty) {
      message = 'Please enter User name';
    }
    submitProfileErrorMessage.value = message;

    if (message != null) {
      return '';
    }
  }

  String? validateUserEmail(String? userEmail) {
    String? message;

    if (userEmail == null || userEmail.isEmpty || userEmail.trim().isEmpty) {
      message = 'Please enter valid email';
    }
    submitProfileErrorMessage.value = message;

    return message;
  }

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

  Future<void> sendSubmitUserProfileRequest(String jwtToken) async {
    if (!isLoadingNotifier.value) {
      submitProfileErrorMessage.value = null;
      if (submitUSerProfileFormKey.currentState != null &&
          submitUSerProfileFormKey.currentState!.validate()) {
        startLoading();
        submitUSerProfileFormKey.currentState!.save();
        final String userName = userNameController.text;
        final String userEmail = userEmailController.text;

        final Either<String, NetworkResponse> response =
            await submitUserProfileUsecase(SubmitUserProfileUsecaseParams(
                email: userEmail, name: userName, jwtToken: jwtToken));

        response.fold(
          (message) {
            stopLoading();
            submitProfileErrorMessage.value = message;
          },
          (result) {
            stopLoading();
            if (result.status) {
              submitProfileErrorMessage.value = null;
              print('Data ${result.status}');
            } else {
              submitProfileErrorMessage.value =
                  Strings.errorMessageSomethingWentWrong;
            }
          },
        );
      }
    } else {
      log('A request to send Login OTP is already in progress');
    }
  }
}
