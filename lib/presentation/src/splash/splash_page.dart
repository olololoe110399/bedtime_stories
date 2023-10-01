import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'splash_vm.dart';
import 'splash_state.dart';

@RoutePage()
class SplashPage extends StatefulHookConsumerWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _PageState();
}

class _PageState extends BasePageState<SplashPage,SplashState,
    AutoDisposeStateNotifierProvider<SplashVM, WrapState<SplashState>>> {
  @override
  AutoDisposeStateNotifierProvider<SplashVM, WrapState<SplashState>>
      get provider => splashVMProvider;

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold();
  }
}
