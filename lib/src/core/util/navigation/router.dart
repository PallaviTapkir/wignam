import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wignam/src/feature/auth/home/presentation/view/view.dart';
import 'package:wignam/src/feature/auth/profile/presentation/view/view.dart';
import 'package:wignam/src/feature/auth/verify_otp/presentation/view/view.dart';

import '../../../feature/auth/login/presentation/view/view.dart';
import 'pages.dart';

enum NavigationType { add, replaceCurrent, replaceAll, removeUntil }

///[RouteManger] is the helper class used by the [MaterialApp] widget
class RouteManger extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  RouteManger._private();

  static final _instance = RouteManger._private();

  static RouteManger get instance => _instance;

  ///[_pages] maintains the stack of routes in the navigation
  static final List<Page> _pages = <Page>[];

  ///[_defaultInitialPage] is the page that is loaded first when the app launches
  static const String _defaultInitialPage = Pages.login;

  static BuildContext? get currentContext =>
      _instance.navigatorKey.currentContext;

  static void init() {
    try {
      _instance.navigatorKey = GlobalKey<NavigatorState>();
      if (_pages.isEmpty) {
        _pages.add(_instance
            ._createPage(const RouteSettings(name: _defaultInitialPage)));
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  ///[navigatorKey] is the global key used for by router for navigation
  @override
  late final GlobalKey<NavigatorState> navigatorKey;

  // @override
  // GlobalKey<NavigatorState> get key => navigatorKey;

  ///[currentRoute] returns null if there is no current route, or it is annonymous
  static String? get currentRoute =>
      /*_pages.isNotEmpty ? _pages.last.name : null;*/ _pages.isNotEmpty
          ? _pages.last.name
          : '/';

  /// When no user is logged-in, calling [_loginSessionAwareRedirection] redirects the user to the [noSessionPage]
  /// And redirects to [page] when user is logged in
  /// Default value of [noSessionPage] is set to [LoginView]
  static Widget _loginSessionAwareRedirection(Widget page,
      {Widget noSessionPage = const LoginView()}) {
    return page;
  }

  @override
  Future<bool> popRoute() async {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {}

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
  }

  static void navigateTo(String name,
      {String removeUntilRoute = Pages.root,
      dynamic arguments,
      final NavigationType navigationType = NavigationType.add}) {
    switch (navigationType) {
      case NavigationType.add:
        _pages.add(instance
            ._createPage(RouteSettings(name: name, arguments: arguments)));
        break;

      case NavigationType.replaceCurrent:
        if (_pages.isNotEmpty) {
          _pages.removeLast();
        }
        _pages.add(instance
            ._createPage(RouteSettings(name: name, arguments: arguments)));
        break;

      case NavigationType.replaceAll:
        if (_pages.isNotEmpty) {
          _pages.clear();
        }
        _pages.add(instance
            ._createPage(RouteSettings(name: name, arguments: arguments)));
        break;

      case NavigationType.removeUntil:
        while (_pages.isNotEmpty &&
            _pages.last.name != null &&
            _pages.last.name!.compareTo(removeUntilRoute) != 0) {
          _pages.removeLast();
        }
        _pages.add(instance
            ._createPage(RouteSettings(name: name, arguments: arguments)));
        break;
    }

    try {
      instance.notifyListeners();
    } catch (e) {
      log('Error calling notifyListeners: $e');
    }
  }

  static void navigateBack({
    bool useContextBasedPop = false,
    BuildContext? context,
    bool rootNavigator = false,
  }) {
    if (useContextBasedPop && context != null) {
      Navigator.of(context, rootNavigator: rootNavigator).pop();
    } else {
      _instance.popRoute();
    }
  }

  static void navigateBackTo(String name) {
    while (_pages.length > 1 &&
        _pages.last.name != null &&
        _pages.last.name!.compareTo(name) != 0) {
      _pages.removeLast();
    }
    _instance.notifyListeners();
  }

  MaterialPage _createPage(RouteSettings settings) {
    late final Widget child;

    switch (settings.name) {
      case Pages.root:
      case Pages.login:
        child = const LoginView();
        break;
      case Pages.verifyOTP:
        child = OTPViewScreen(settings.arguments as OTPViewParams);
        break;

      case Pages.profile:
        child = SubmitUserProfileView(
            settings.arguments as SubmitUserProfileParams);
        break;

      case Pages.home:
        child = const HomeView();
        break;
    }

    return MaterialPage(
        child: child,
        key: ValueKey(settings.name),
        name: settings.name,
        arguments: settings.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Navigator(
        key: navigatorKey,
        pages: List.of(_pages),
        onPopPage: _onPopPage,
      ),
    );
  }
}

class RouteInformationParserManager
    extends RouteInformationParser<RouteInformation> {
  RouteInformationParserManager._private();

  static final _instance = RouteInformationParserManager._private();

  static RouteInformationParserManager get instance => _instance;

  @override
  Future<RouteInformation> parseRouteInformation(
      RouteInformation routeInformation) async {
    return routeInformation;
  }
}
