import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';

@freezed
class Story with _$Story {
  const factory Story({
    @Default(Story.defaultId) String id,
    @Default(Story.defaultStory) String story,
    @Default(Story.defaultImagePath) String imagePath,
    @Default(Story.defaultTitle) String title,
    @Default(Story.defaultDate) DateTime? date,
    @Default(Story.defaultIsStop) bool? isStop,
  }) = _Story;

  static const defaultId = "";
  static const defaultStory = "";
  static const defaultImagePath = "";
  static const defaultTitle = "";
  static const DateTime? defaultDate = null;
  static const defaultIsStop = false;
}
