import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:injectable/injectable.dart';

abstract class LocalDataSource {
  Stream<List<StoryHiveModel>> getStoryList();
  Future<void> addStoryItem(StoryHiveModel item);
  Future<void> initDatabaseStory();
  Future<void> removeStoryItem(int index);
  Future<bool> isStoryItemAdded(String id);
}

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl({
    required this.hiveDatabaseOperation,
  });

  final HiveDatabaseOperation<StoryHiveModel> hiveDatabaseOperation;

  @override
  Future<void> addStoryItem(StoryHiveModel item) async {
    await hiveDatabaseOperation.addOrUpdateItem(item);
  }

  @override
  Stream<List<StoryHiveModel>> getStoryList() {
    return hiveDatabaseOperation.streamItems();
  }

  @override
  Future<bool> isStoryItemAdded(String id) async {
    return hiveDatabaseOperation.getItem(id) != null;
  }

  @override
  Future<void> removeStoryItem(int index) async {
    await hiveDatabaseOperation.deleteItem(index.toString());
  }

  @override
  Future<void> initDatabaseStory() async {
    await hiveDatabaseOperation.start();
  }
}
