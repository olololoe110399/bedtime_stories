import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetStoryByIdUsecase implements UseCase<Story, GetStoryByIdParams> {
  final OpenAIRepository _repository;

  GetStoryByIdUsecase(this._repository);

  @override
  Future<Result<Story>> call(GetStoryByIdParams params) async {
    return await _repository.getStoryById(params.id);
  }
}

class GetStoryByIdParams extends Equatable {
  final String id;
  const GetStoryByIdParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
