import 'package:bedtime_stories/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_hive_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.storyModelId)
class StoryHiveModel with EquatableMixin, HiveModelMixin {
  @override
  String get key => StringUtils.idGenerator();

  @HiveField(0)
  final String? story;
  @HiveField(1)
  final String? imagePath;

  const StoryHiveModel({
    required this.story,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => _$StoryHiveModelToJson(this);

  @override
  List<Object?> get props => [
        story,
        imagePath,
      ];

  StoryHiveModel copyWith({
    String? story,
    String? imagePath,
  }) {
    return StoryHiveModel(
      story: story ?? this.story,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

extension StoryHiveModelExtension on StoryHiveModel {
  bool get isEmpty => story == null || imagePath == null;
}
