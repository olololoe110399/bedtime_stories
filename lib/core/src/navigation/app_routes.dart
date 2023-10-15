import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/presentation/presentation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

part 'app_routes.gr.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, initial: true),
        AutoRoute(page: HistoryRoute.page),
        AutoRoute(page: DefineStoryRoute.page),
        AutoRoute(page: JailbreakRoute.page),
        AutoRoute(page: StoryDetailRoute.page),
      ];
}
