import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'jailbreak_vm.dart';
import 'jailbreak_state.dart';

@RoutePage()
class JailbreakPage extends StatefulHookConsumerWidget {
  const JailbreakPage({super.key});

  @override
  ConsumerState<JailbreakPage> createState() => _PageState();
}

class _PageState extends BasePageState<JailbreakPage, JailbreakState,
    AutoDisposeStateNotifierProvider<JailbreakVM, WrapState<JailbreakState>>> {
  @override
  AutoDisposeStateNotifierProvider<JailbreakVM, WrapState<JailbreakState>>
      get provider => jailbreakVMProvider;

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Your device is detected jailbreak!'),
      ),
    );
  }
}
