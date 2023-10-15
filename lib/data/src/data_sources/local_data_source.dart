import 'package:bedtime_stories/data/data.dart';
import 'package:injectable/injectable.dart';

abstract class LocalDataSource {
  Stream<List<StoryHiveModel>> getStoryList();
  Future<void> addStoryItem(StoryHiveModel item);
  Future<void> initDatabaseStory();
  Future<StoryHiveModel?> getStoryItem(String id);
  Future<void> removeStoryItem(int index);
  Future<bool> isStoryItemAdded(String id);
}

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl({
    required this.storyHiveOperation,
  });

  final StoryHiveOperation storyHiveOperation;

  @override
  Future<void> addStoryItem(StoryHiveModel item) async {
    await storyHiveOperation.addOrUpdateItem(item);
  }

  @override
  Stream<List<StoryHiveModel>> getStoryList() {
    return storyHiveOperation.streamItems();
  }

  @override
  Future<StoryHiveModel?> getStoryItem(String id) async {
    return storyHiveOperation.getItem(id);
  }

  @override
  Future<bool> isStoryItemAdded(String id) async {
    return storyHiveOperation.getItem(id) != null;
  }

  @override
  Future<void> removeStoryItem(int index) async {
    await storyHiveOperation.deleteItem(index.toString());
  }

  @override
  Future<void> initDatabaseStory() async {
    await storyHiveOperation.start();
  }
}
