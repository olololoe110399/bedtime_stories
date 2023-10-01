import 'package:{{name.snakeCase()}}/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature.lowerCase()}}_state.freezed.dart';

@freezed
class {{feature.pascalCase()}}State extends BaseState with _${{feature.pascalCase()}}State {
  const factory {{feature.pascalCase()}}State({
    {{#states}}{{#default}}@Default({{default}}) {{type}} {{name.camelCase()}}, 
    {{/default}}{{^default}}{{type}}? {{name.camelCase()}},
    {{/default}}{{/states}} // Add More State here
  }) = _{{feature.pascalCase()}}State;
}
