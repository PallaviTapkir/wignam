import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/value/colors.dart';
import '../logic/controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewController>(
      create: (_) => HomeViewController(),
      child: Consumer<HomeViewController>(
        builder: (_, controller, ___) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: AppColors.primaryLighter,
                title: const Text('Home',
                    style: TextStyle(fontSize: 16.0)),
              ),
              body: Column());
        },
      ),
    );
  }
}
