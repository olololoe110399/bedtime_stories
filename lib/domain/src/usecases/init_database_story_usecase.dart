import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

@Injectable()
class InitDatabaseStoryUsecase implements UseCase<Unit, Unit> {
  final OpenAIRepository _repository;

  InitDatabaseStoryUsecase(this._repository);

  @override
  Future<UnitResult> call(Unit params) async {
    return await _repository.initDatabaseStory();
  }
}
