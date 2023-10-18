import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';

abstract class OpenAIRepository {
  Stream<Result<Story>> completion({
    required String model,
    required int maxTokens,
    required double temperature,
    required List<Message> messages,
  });

  Stream<Result<List<Story>>> streamStories();

  Future<Result<Story>> getStoryById(String id);

  Future<UnitResult> initDatabaseStory();

  Future<Result<String>> saveStories(Story story);
}
