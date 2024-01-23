import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

abstract class BasePageState<T extends StatefulHookConsumerWidget,
        S extends BaseState, P extends ProviderListenable<WrapState<S>>>
    extends BasePageStateDelegete<T, S, P> with AppErrorListenerMixin {
  @override
  void buildPageListener() {
    useEffect(
      () {
        return () {
          disposeBag.dispose();
        };
      },
      [],
    );
    ref.listen(provider.select((value) => value.appExceptionWrapper),
        (previous, next) {
      if (previous != next && next != null) {
        handleException.handleException(
          next,
          context,
          this,
        );
      }
    });
  }
}

abstract class BasePageStateDelegete<T extends StatefulHookConsumerWidget,
        S extends BaseState, P extends ProviderListenable<WrapState<S>>>
    extends ConsumerState<T> with AutomaticKeepAliveClientMixin, LogMixin {
  late final AppHandleException handleException = AppHandleException();

  late final DisposeBag disposeBag = DisposeBag();

  bool isAppWidget = false;

  @override
  bool get wantKeepAlive => false;

  P get provider;

  late MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppDimen.of(context);
    mediaQueryData = MediaQuery.of(context);
    buildPageListener();
    return isAppWidget
        ? buildPage(context)
        : Stack(
            children: [
              buildPage(context),
              Visibility(
                visible: ref.watch(provider.select((value) => value.isLoading)),
                child: buildPageLoading(),
              ),
            ],
          );
  }

  void buildPageListener();

  Widget buildPage(BuildContext context);

  Widget buildPageLoading() => Scaffold(
        body: Stack(
          children: [
            const ModalBarrier(
              dismissible: false,
              color: AppColors.primary,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/json/loading.json'),
                Text(
                  'Generating Story...\nPlease wait a moment.',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: Dimens.d18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: Dimens.d18,
                ),
                CircularProgressIndicator(
                  color: AppColors.darkBlue,
                ),
              ],
            ),
          ],
        ),
      );
}
