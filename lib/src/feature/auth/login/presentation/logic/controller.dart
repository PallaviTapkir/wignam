import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wignam/src/feature/auth/verify_otp/presentation/view/view.dart';

import '../../../../../core/api/network_response.dart';
import '../../../../../core/util/navigation/pages.dart';
import '../../../../../core/util/navigation/router.dart';
import '../../../../../core/value/strings.dart';
import '../../domain/usecase/send_login_otp_usecase.dart';

class LoginViewController extends ChangeNotifier {
  LoginViewController({
    required this.sendLoginOTPUsecase,
  }) {
    loginFormKey = GlobalKey<FormState>();
    mobileNumberController = TextEditingController();
  }

  final SendLoginOTPUsecase sendLoginOTPUsecase;

  late final GlobalKey<FormState> loginFormKey;
  late final TextEditingController mobileNumberController;

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

  String? validateMobileNumber(String? mobile) {
    String? message;

    if (mobile == null || mobile.isEmpty || mobile.trim().isEmpty) {
      message = 'Please enter your Mobile number';
    }
    loginErrorMessage.value = message;

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

  Future<void> sendLoginOTP() async {
    if (!isLoadingNotifier.value) {
      loginErrorMessage.value = null;
      if (loginFormKey.currentState != null &&
          loginFormKey.currentState!.validate()) {
        startLoading();
        loginFormKey.currentState!.save();
        final String mobile = mobileNumberController.text;
        final Either<String, NetworkResponse> response =
            await sendLoginOTPUsecase(SendLoginOTPUsecaseParams(
          mobile: mobile,
        ));

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
              print('Data ${result.requestId} $mobile');
              RouteManger.navigateTo(Pages.verifyOTP,
                  arguments: OTPViewParams(
                      requestId: result.requestId!, mobileNo: mobile));
            } else {
              loginErrorMessage.value = Strings.errorMessageSomethingWentWrong;
            }
          },
        );
      }
    } else {
      log('A request to send Login OTP is already in progress');
    }
  }
}
