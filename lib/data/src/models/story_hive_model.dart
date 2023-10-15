import 'package:bedtime_stories/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_hive_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.storyModelId)
class StoryHiveModel with EquatableMixin, HiveModelMixin {
  static const String storyKey = 'story';

  @override
  String get key => microsecondsSinceEpoch ?? storyKey;

  @HiveField(0)
  final String? story;
  @HiveField(1)
  final String? imagePath;
  @HiveField(2)
  final String? microsecondsSinceEpoch;
  @HiveField(3)
  final String? title;

  const StoryHiveModel({
    required this.story,
    required this.imagePath,
    required this.microsecondsSinceEpoch,
    required this.title,
  });

  Map<String, dynamic> toJson() => _$StoryHiveModelToJson(this);

  @override
  List<Object?> get props => [
        story,
        imagePath,
        microsecondsSinceEpoch,
        title,
      ];

  StoryHiveModel copyWith({
    String? story,
    String? imagePath,
    String? title,
    String? microsecondsSinceEpoch,
  }) {
    return StoryHiveModel(
      story: story ?? this.story,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      microsecondsSinceEpoch:
          microsecondsSinceEpoch ?? this.microsecondsSinceEpoch,
    );
  }
}

extension StoryHiveModelExtension on StoryHiveModel {
  bool get isEmpty =>
      story == null ||
      imagePath == null ||
      title == null ||
      microsecondsSinceEpoch == null;
}
