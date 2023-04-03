import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlledView<T extends ChangeNotifier> extends StatelessWidget {
  const ControlledView(
      {Key? key,
      this.controller,
      required this.builder,
      this.addChageNotifierProviderAsParent = true})
      : assert((addChageNotifierProviderAsParent && controller != null) ||
            !addChageNotifierProviderAsParent),
        super(key: key);

  final T? controller;
  final Widget Function(T) builder;
  final bool addChageNotifierProviderAsParent;

  @override
  Widget build(BuildContext context) {
    if (addChageNotifierProviderAsParent && controller != null) {
      return ChangeNotifierProvider<T>.value(
        value: controller!,
        child: Consumer<T>(
          builder: (__, controller, ___) => builder(controller),
        ),
      );
    }
    return Consumer<T>(
      builder: (__, controller, ___) => builder(controller),
    );
  }
}
