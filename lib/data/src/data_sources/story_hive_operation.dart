import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HiveDatabaseOperation)
class StoryHiveOperation extends HiveDatabaseOperation<StoryHiveModel> {
  StoryHiveOperation({required super.primitiveDatabase});
}
