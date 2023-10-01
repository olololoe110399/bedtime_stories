import 'package:auto_route/auto_route.dart';
import 'package:{{name.snakeCase()}}/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '{{feature.lowerCase()}}_vm.dart';
import '{{feature.lowerCase()}}_state.dart';

@RoutePage()
class {{feature.pascalCase()}}Page extends StatefulHookConsumerWidget {
  const {{feature.pascalCase()}}Page({super.key});

  @override
  ConsumerState<{{feature.pascalCase()}}Page> createState() => _PageState();
}

class _PageState extends BasePageState<{{feature.pascalCase()}}Page,{{feature.pascalCase()}}State,
    AutoDisposeStateNotifierProvider<{{feature.pascalCase()}}VM, WrapState<{{feature.pascalCase()}}State>>> {
  @override
  AutoDisposeStateNotifierProvider<{{feature.pascalCase()}}VM, WrapState<{{feature.pascalCase()}}State>>
      get provider => {{feature.camelCase()}}VMProvider;

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold();
  }
}
