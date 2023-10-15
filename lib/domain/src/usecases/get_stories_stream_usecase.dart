import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetStoriesStreamUsecase
    implements UseCaseStream<List<Story>, GetStoriesStreamParams> {
  final OpenAIRepository repository;

  GetStoriesStreamUsecase(this.repository);

  @override
  Stream<Result<List<Story>>> call(GetStoriesStreamParams params) {
    return repository.streamStories();
  }
}

class GetStoriesStreamParams extends Equatable {
  const GetStoriesStreamParams();

  @override
  List<Object?> get props => [];
}
