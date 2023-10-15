import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';

@freezed
class Story with _$Story {
  const factory Story({
    @Default(Story.defaultId) String id,
    @Default(Story.defaultStory) String story,
    @Default(Story.defaultImagePath) String imagePath,
  }) = _Story;

  static const defaultId = "";
  static const defaultStory = "";
  static const defaultImagePath = "";
}
