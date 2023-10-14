import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CompletionUsecase implements UseCase<ChatCompletion, CompletionParams> {
  final OpenAIRepository _repository;

  CompletionUsecase(this._repository);

  @override
  Future<Result<ChatCompletion>> call(CompletionParams params) async {
    return await _repository.completion(
      model: params.model,
      maxTokens: params.maxTokens,
      temperature: params.temperature,
      messages: params.messages,
    );
  }
}

class CompletionParams extends Equatable {
  final String model;
  final int maxTokens;
  final double temperature;
  final List<Message> messages;

  const CompletionParams({
    this.model = 'gpt-3.5-turbo',
    this.maxTokens = 500,
    this.temperature = 0.7,
    required this.messages,
  });

  @override
  List<Object?> get props => [
        model,
        maxTokens,
        temperature,
        messages,
      ];
}
