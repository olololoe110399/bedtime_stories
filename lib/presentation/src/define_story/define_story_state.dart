import 'package:bedtime_stories/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'define_story_state.freezed.dart';

@freezed
class DefineStoryState extends BaseState with _$DefineStoryState {
  const factory DefineStoryState({
    @Default(false) bool loading, 
    String? text,
     // Add More State here
  }) = _DefineStoryState;
}
