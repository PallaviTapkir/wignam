import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/http_helper.dart';
import '../../../../../core/value/assets.dart';
import '../../../../../core/value/colors.dart';
import '../../../../../core/value/strings.dart';
import '../../../../../core/widget/button/flat_bottom_soft_button.dart';
import '../../data/datasource/remote_datasource.dart';
import '../../data/repository/repository.dart';
import '../../domain/usecase/send_login_otp_usecase.dart';
import '../logic/controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  void onOTPSendingFailed({
    required final BuildContext context,
    required final String message,
  }) {
    log(message);
  }

  void onLoginFormSubmit({
    required BuildContext context,
    required LoginViewController controller,
  }) {
    try {
      FocusScope.of(context).unfocus();
      controller.otpTextController.clear();
    } catch (e) {
      log('$e');
    }

    controller.sendLoginOTP();
  }

  @override
  Widget build(BuildContext context) {
    final LoginRemoteDatasource remoteDatasource =
        LoginRemoteDatasource(NetworkHelper.instance);
    final LoginRepository repository = LoginRepository(remoteDatasource);

    return ChangeNotifierProvider<LoginViewController>(
      create: (_) => LoginViewController(
        sendLoginOTPUsecase: SendLoginOTPUsecase(repository),
      ),
      child: Consumer<LoginViewController>(
        builder: (_, controller, ___) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: //Logo
                        SvgPicture.asset(
                      Assets.logo,
                      height: 36.0,
                      width: 36.0,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  //Login Form
                  Stack(
                    children: [
                      //Gradient
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              AppColors.white,
                              AppColors.white,
                            ],
                            stops: [
                              0.0,
                              0.35,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 32.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // Input + Submit Button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Form(
                                key: controller.loginFormKey,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        textInputAction: TextInputAction.done,
                                        maxLines: 1,
                                        controller:
                                            controller.mobileNumberController,
                                        validator:
                                            controller.validateMobileNumber,
                                        onFieldSubmitted: (value) =>
                                            onLoginFormSubmit(
                                          context: context,
                                          controller: controller,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              right: 124.0,
                                              left: 10.0,
                                              top: 18.0,
                                              bottom: 18.0),
                                          isDense: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.secondary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.secondary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.secondary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          hintText: Strings
                                              .loginScreenUsernameInputHint,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Login Form Submission Button
                            Align(
                              alignment: Alignment.center,
                              child: FlatBottomSoftButton(
                                onPressed: () => onLoginFormSubmit(
                                  context: context,
                                  controller: controller,
                                ),
                                highlightFactor: 0.70,
                                height: 35.0,
                                width: 300,
                                color: AppColors.secondary,
                                child: const Text(
                                  Strings.loginScreenContinueLabel,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            // Login Error
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                bottom: 16.0,
                              ),
                              child: SizedBox(
                                height: 24.0,
                                child: Row(
                                  children: [
                                    ValueListenableBuilder<bool>(
                                      valueListenable:
                                          controller.isLoadingNotifier,
                                      builder: (_, value, __) {
                                        return value
                                            ? const SizedBox(
                                                width: 16.0,
                                                height: 16.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.secondary,
                                                ),
                                              )
                                            : const SizedBox.shrink();
                                      },
                                    ),
                                    ValueListenableBuilder<String?>(
                                      valueListenable:
                                          controller.loginErrorMessage,
                                      builder: (_, value, __) {
                                        return Text(
                                          !controller.isLoading && value != null
                                              ? value
                                              : '',
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
