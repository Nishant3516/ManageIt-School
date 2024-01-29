import 'package:flutter/material.dart';

class ManageItRouter {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static BuildContext get context => _navigatorKey.currentContext!;

  static Future<T?> push<T extends Object>(
    String routeName, {
    Object? arguments,
  }) async {
    var result = await _navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );

    return result as T?;
  }

  static bool canPop() => _navigatorKey.currentState!.canPop();

  static void pop<T extends Object?>([T? result]) =>
      _navigatorKey.currentState!.pop<T>(result);

  static Future<T?> replace<T extends Object, TO extends Object>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static Future<T?> pushNewStack<T extends Object?>(
    String newRouteName, {
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      newRouteName,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future<T?> popAndPush<T extends Object, TO extends Object>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.popAndPushNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }
}
