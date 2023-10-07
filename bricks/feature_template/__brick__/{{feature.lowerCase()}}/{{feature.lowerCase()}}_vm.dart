import 'dart:async';

import 'package:{{name.snakeCase()}}/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '{{feature.lowerCase()}}_event.dart';
import '{{feature.lowerCase()}}_state.dart';

final {{feature.camelCase()}}VMProvider = StateNotifierProvider.autoDispose<
    {{feature.pascalCase()}}VM, WrapState<{{feature.pascalCase()}}State>>(
  (ref) => {{feature.pascalCase()}}VM(ref),
);

class {{feature.pascalCase()}}VM
    extends BaseVM<{{feature.pascalCase()}}Event, {{feature.pascalCase()}}State> {
  {{feature.pascalCase()}}VM(Ref ref) : super(const {{feature.pascalCase()}}State(), ref){
    Future.microtask(
      () {
        add(const {{feature.pascalCase()}}EventLoaded());
      },
    );
  }

  @override
  void add({{feature.pascalCase()}}Event event) {
    switch (event) {
      {{#events}}case {{feature.pascalCase()}}Event{{name.pascalCase()}} event:
        on{{feature.pascalCase()}}Event{{name.pascalCase()}}(event);
        {{/events}} // Add More Event here
        break;
      default:
    }
  }

{{#events}}
  Future<void> on{{feature.pascalCase()}}Event{{name.pascalCase()}}(
    {{feature.pascalCase()}}Event{{name.pascalCase()}} event,
  ) async {
    // TODO: Implement {{feature.pascalCase()}}Event{{name.pascalCase()}}
  }
{{/events}}
}
