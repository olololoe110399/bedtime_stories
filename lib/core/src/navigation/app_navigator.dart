import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

final appNavigatorProvider = Provider<AppNavigator>((ref) {
  return AppNavigator(ref.read(appRouterProvider));
});

class AppNavigator with LogMixin {
  AppNavigator(this.appRouter);

  final AppRouter appRouter;

  final tabsRoutes = const [];

  TabsRouter? tabsRouter;

  StackRouter? get _currentTabRouter =>
      tabsRouter?.stackRouterOfIndex(tabsRouter?.activeIndex ?? 0);

  StackRouter get _currentTabRouterOrRootRouter =>
      _currentTabRouter ?? appRouter;
  BuildContext? get _currentTabRouterContext =>
      _currentTabRouter?.navigatorKey.currentContext;
  BuildContext get _currentTabContextOrRootContext =>
      _currentTabRouterContext ?? _rootRouterContext;

  bool get canPopSelfOrChildren => appRouter.canPop();

  BuildContext get _rootRouterContext => appRouter.navigatorKey.currentContext!;

  void popUntilRootOfCurrentTab() {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (_currentTabRouter?.canPop() == true) {
      _currentTabRouter?.popUntilRoot();
    }
  }

  Future<T?> push<T extends Object?>(PageRouteInfo pageRouteInfo) {
    return appRouter.push<T>(pageRouteInfo);
  }

  Future<void> pushAll(List<PageRouteInfo> listPageRouteInfo) {
    return appRouter.pushAll(listPageRouteInfo);
  }

  Future<T?> replace<T extends Object?>(PageRouteInfo pageRouteInfo) {
    return appRouter.replace<T>(pageRouteInfo);
  }

  Future<void> replaceAll(List<PageRouteInfo> listPageRouteInfo) {
    return appRouter.replaceAll(listPageRouteInfo);
  }

  Future<bool> pop<T extends Object?>(
      {T? result, bool useRootNavigator = false}) {
    return useRootNavigator
        ? appRouter.pop<T>(result)
        : _currentTabRouterOrRootRouter.pop<T>(result);
  }

  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    PageRouteInfo pageRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  }) {
    return useRootNavigator
        ? appRouter.popAndPush<T, R>(pageRouteInfo, result: result)
        : _currentTabRouterOrRootRouter.popAndPush<T, R>(
            pageRouteInfo,
            result: result,
          );
  }

  void popUntilRoot({bool useRootNavigator = false}) {
    useRootNavigator
        ? appRouter.popUntilRoot()
        : _currentTabRouterOrRootRouter.popUntilRoot();
  }

  void popUntilRouteName(String routeName) {
    appRouter.popUntilRouteWithName(routeName);
  }

  bool removeUntilRouteName(String routeName) {
    return appRouter.removeUntil((route) => route.name == routeName);
  }

  bool removeAllRoutesWithName(String routeName) {
    return appRouter.removeWhere((route) => route.name == routeName);
  }

  Future<void> popAndPushAll(List<PageRouteInfo> listPageRouteInfo) {
    return appRouter.popAndPushAll(listPageRouteInfo);
  }

  bool removeLast() {
    return appRouter.removeLast();
  }

  void showErrorSnackBar({required String message, Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      backgroundColor: Colors.red,
    );
  }

  void showSuccessSnackBar({required String message, Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      backgroundColor: Colors.green,
    );
  }

  void shareWithResult(String content) async {
    await Share.shareWithResult(content);
    logD('Share With Result!');
    logD(content);
  }
}
