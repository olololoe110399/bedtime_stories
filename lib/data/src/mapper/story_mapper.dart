import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class StoryDataMapper extends BaseDataMapper<StoryHiveModel, Story> {
  StoryDataMapper(
    this.usageDataMapper,
    this.choiceDataMapper,
  );

  final UsageDataMapper usageDataMapper;
  final ChoiceDataMapper choiceDataMapper;

  @override
  Story mapToEntity(StoryHiveModel? data) {
    return Story(
      id: data?.key ?? Story.defaultId,
      story: data?.story ?? Story.defaultStory,
      imagePath: data?.imagePath ?? Story.defaultImagePath,
    );
  }
}
