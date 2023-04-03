import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/http_helper.dart';
import '../../../../../core/value/assets.dart';
import '../../../../../core/value/colors.dart';
import '../../../../../core/value/strings.dart';
import '../../../../../core/widget/button/flat_bottom_soft_button.dart';
import '../../data/datasource/remote_datasource.dart';
import '../../data/repository/repository.dart';
import '../../domain/usecase/verify_otpotp_usecase.dart';
import '../logic/controller.dart';

class OTPViewParams {
  OTPViewParams({required this.requestId, required this.mobileNo});

  final String requestId;
  final String mobileNo;
}

class OTPViewScreen extends StatelessWidget {
  OTPViewScreen(this.params, {Key? key}) : super(key: key) {
    mobileNo = params.mobileNo;
    requestId = params.requestId;
  }

  final OTPViewParams params;
  late final String mobileNo;
  late final String requestId;

  @override
  Widget build(BuildContext context) {
    final VerifyOTPRemoteDatasource remoteDatasource =
        VerifyOTPRemoteDatasource(NetworkHelper.instance);
    final VerifyOTPRepository repository =
        VerifyOTPRepository(remoteDatasource);

    return ChangeNotifierProvider<VerifyOTPController>(
      create: (_) => VerifyOTPController(
        verifyOTPUsecase: VerifyOTPUsecase(repository),
      ),
      child: Consumer<VerifyOTPController>(
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
                    height: 100,
                    width: 100,
                  ),
                  //Logo

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
                                'Enter OTP',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'OTP has been sent to +91-${params.mobileNo}',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30.0,
                                horizontal: 20.0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Input
                                  Form(
                                    key: controller.otpFormKey,
                                    child: PinCodeTextField(
                                      appContext: context,
                                      length: 6,
                                      controller: controller.otpTextController,
                                      autoDisposeControllers: false,
                                      onChanged: (pin) {},
                                      onSubmitted: (pin) =>
                                          onOTPSubmit(controller, pin),
                                      onCompleted: (pin) =>
                                          onOTPSubmit(controller, pin),
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        fieldWidth: 40.0,
                                        fieldHeight: 45.0,
                                        borderWidth: 1.0,
                                        errorBorderColor: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                  ),
                                  // Error Message
                                  Padding(
                                    padding: const EdgeInsets.only(
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
                                                  ? const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 16.0),
                                                      child: SizedBox(
                                                        width: 16.0,
                                                        height: 16.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: AppColors
                                                              .secondary,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox.shrink();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatBottomSoftButton(
                                    onPressed: () => {
                                      onOTPSubmit(controller,
                                          controller.otpTextController.text)
                                    },
                                    highlightFactor: 0.70,
                                    height: 35.0,
                                    width: 300,
                                    color: AppColors.secondary,
                                    child: const Text(
                                      Strings.verifyOTPSubmitLabel,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () => {
                                            Navigator.of(context).pop(),
                                          },
                                      child: const Text(Strings.retryMessage)),
                                ],
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

  onOTPSubmit(VerifyOTPController controller, String pin) {
    controller.verifyOTP(pin, params.requestId, params.mobileNo);
  }
}
