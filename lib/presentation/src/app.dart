import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageState<MyApp, CommonState,
    StateNotifierProvider<CommonVM, WrapState<CommonState>>> {
  @override
  StateNotifierProvider<CommonVM, WrapState<CommonState>> get provider =>
      commonVMProvider;
  @override
  bool get isAppWidget => true;

  @override
  Widget buildPage(BuildContext context) {
    final themeMode =
        ref.watch(provider.select((value) => value.data.themeMode));
    final locale = ref.watch(provider.select((value) => value.data.locale));
    final appRouter = ref.watch(appRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(
        DeviceConstants.designDeviceWidth,
        DeviceConstants.designDeviceHeight,
      ),
      builder: (context, _) => DevicePreview(
        enabled: DeviceConstants.enableDevicePreview,
        builder: (_) => MaterialApp.router(
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);

            final widget = MediaQuery(
              data: data.copyWith(textScaleFactor: 1.0),
              child: child ?? const SizedBox.shrink(),
            );

            return DeviceConstants.enableDevicePreview
                ? DevicePreview.appBuilder(context, widget)
                : widget;
          },
          routerDelegate: appRouter.delegate(
            deepLinkBuilder: (deepLink) {
              return DeepLink.defaultPath;
            },
            navigatorObservers: () => [AppNavigatorObserver()],
          ),
          routeInformationParser: appRouter.defaultRouteParser(),
          title: UiConstants.materialAppTitle,
          color: AppColors.primary,
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) =>
                  supportedLocales.contains(locale)
                      ? locale
                      : const Locale(LocaleConstants.defaultLocale),
          locale: DeviceConstants.enableDevicePreview
              ? DevicePreview.locale(context)
              : Locale(locale),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
