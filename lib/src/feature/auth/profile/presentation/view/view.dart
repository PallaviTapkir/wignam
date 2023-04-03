import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wignam/src/feature/auth/profile/data/datasource/remote_datasource.dart';
import 'package:wignam/src/feature/auth/profile/data/repository/repository.dart';
import 'package:wignam/src/feature/auth/profile/domain/usecase/submit_user_profile_usecase.dart';
import 'package:wignam/src/feature/auth/profile/presentation/logic/controller.dart';

import '../../../../../core/api/http_helper.dart';
import '../../../../../core/value/colors.dart';
import '../../../../../core/value/strings.dart';
import '../../../../../core/widget/button/flat_bottom_soft_button.dart';

class SubmitUserProfileParams {
  SubmitUserProfileParams({
    required this.jwtToken,
  });

  final String jwtToken;
}

class SubmitUserProfileView extends StatelessWidget {
  SubmitUserProfileView(this.params, {Key? key}) : super(key: key);

  final SubmitUserProfileParams params;

  void onProfileSubmitted({
    required BuildContext context,
    required SubmitUserProfileViewController controller,
  }) {
    try {
      FocusScope.of(context).unfocus();
    } catch (e) {
      log('$e');
    }

    print('JWT ${params.jwtToken}');
    controller.sendSubmitUserProfileRequest(params.jwtToken);
  }

  @override
  Widget build(BuildContext context) {
    final SubmitProfileRemoteDatasource remoteDatasource =
        SubmitProfileRemoteDatasource(NetworkHelper.instance);
    final SubmitProfileRepository repository =
        SubmitProfileRepository(remoteDatasource);

    return ChangeNotifierProvider<SubmitUserProfileViewController>(
      create: (_) => SubmitUserProfileViewController(
        submitUserProfileUsecase: SubmitUserProfileUsecase(repository),
      ),
      child: Consumer<SubmitUserProfileViewController>(
        builder: (_, controller, ___) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              title: const Text('Profile', style: TextStyle( fontSize: 16.0),),
              backgroundColor: AppColors.primaryLighter,
            ),
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
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                Strings.welcomeMessage,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            // Input + Submit Button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Form(
                                key: controller.submitUSerProfileFormKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        maxLines: 1,
                                        controller:
                                            controller.userNameController,
                                        validator:
                                            controller.validateUserNameInput,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              right: 124.0,
                                              left: 10.0,
                                              top: 18.0,
                                              bottom: 18.0),
                                          isDense: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.primaryLight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.primaryLight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.primaryLight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          hintText: Strings.userNameHint,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                        maxLines: 1,
                                        controller:
                                            controller.userEmailController,
                                        validator: controller.validateUserEmail,
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
                                          hintText: Strings.userEmailHint,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: FlatBottomSoftButton(
                                onPressed: () => onProfileSubmitted(
                                  context: context,
                                  controller: controller,
                                ),
                                highlightFactor: 0.70,
                                height: 35.0,
                                width: 300,
                                color: AppColors.secondary,
                                child: const Text(
                                  Strings.submitLabel,
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
                                          controller.submitProfileErrorMessage,
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
