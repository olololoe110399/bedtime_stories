import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveStoryLocalUsecase implements UseCase<String, SaveStoryLocalParams> {
  final OpenAIRepository _repository;

  SaveStoryLocalUsecase(this._repository);

  @override
  Future<Result<String>> call(SaveStoryLocalParams params) async {
    return await _repository.saveStories(params.story);
  }
}

class SaveStoryLocalParams extends Equatable {
  final Story story;
  const SaveStoryLocalParams({
    required this.story,
  });

  @override
  List<Object?> get props => [story];
}
