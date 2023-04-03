import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wignam/src/feature/auth/profile/presentation/view/view.dart';

import '../../../../../core/api/network_response.dart';
import '../../../../../core/util/navigation/pages.dart';
import '../../../../../core/util/navigation/router.dart';
import '../../../../../core/value/strings.dart';
import '../../domain/usecase/verify_otpotp_usecase.dart';

class VerifyOTPController extends ChangeNotifier {
  VerifyOTPController({
    required this.verifyOTPUsecase,
  }) {
    otpFormKey = GlobalKey<FormState>();
    otpTextController = TextEditingController();
  }

  final VerifyOTPUsecase verifyOTPUsecase;

  bool get isLoading => isLoadingNotifier.value;
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> loginErrorMessage = ValueNotifier<String?>(null);

  late final GlobalKey<FormState> otpFormKey;
  late final TextEditingController otpTextController;

  final ValueNotifier<bool> isLoadingOTPViewNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<String?> otpWindowErrorMessage =
      ValueNotifier<String?>(null);

  void _refresh() => notifyListeners();

  String? validateOTPInput(String? otp) {
    String? message;

    if (otp == null || otp.isEmpty || otp.trim().isEmpty) {
      message = 'Please enter OTP';
    } else {
      try {
        int.parse(otp);
      } catch (e) {
        message = 'Enter numbers only';
      }
    }
    otpWindowErrorMessage.value = message;

    if (message != null) {
      return '';
    }
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

  void verifyOTP(String pin, String requestId, String mobileNo) async {
    final Either<String, NetworkResponse> response = await verifyOTPUsecase(
        VerifyOTPUsecaseParams(requestId: requestId, otp: pin));

    response.fold(
      (message) {
        stopLoading();
        loginErrorMessage.value = message;
      },
      (result) {
        stopLoading();
        if (result.status) {
          loginErrorMessage.value = null;
          otpWindowErrorMessage.value = null;
          print('Data ${result.profileExists} ${result.jwt}');
          handleResponse(result);
        } else {
          loginErrorMessage.value = Strings.errorMessageSomethingWentWrong;
        }
      },
    );
  }

  void handleResponse(NetworkResponse result) {
    if (result.status && result.profileExists!) {
      RouteManger.navigateTo(Pages.home);
    } else {
      RouteManger.navigateTo(Pages.profile,
          arguments: SubmitUserProfileParams(
            jwtToken: result.jwt!,
          ));
    }
  }
}
