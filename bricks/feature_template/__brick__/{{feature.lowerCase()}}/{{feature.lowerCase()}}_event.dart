import 'package:{{name.snakeCase()}}/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature.lowerCase()}}_event.freezed.dart';

@freezed
class {{feature.pascalCase()}}Event extends BaseEvent with _${{feature.pascalCase()}}Event {
  {{#events}}
  const factory {{feature.pascalCase()}}Event.{{name.camelCase()}}({{#variables}}
    {{type}} {{name.camelCase()}},{{/variables}}
  ) = {{feature.pascalCase()}}Event{{name.pascalCase()}};
{{/events}}
  // Add More Events here
}
