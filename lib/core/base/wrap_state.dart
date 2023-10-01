import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wrap_state.freezed.dart';

@freezed
class WrapState<T extends BaseState> with _$WrapState<T> {
  const factory WrapState({
    required T data,
    AppExceptionWrapper? appExceptionWrapper,
    @Default(false) bool isLoading,
  }) = _WrapState;
}
