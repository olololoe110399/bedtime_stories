import 'package:bedtime_stories/core/core.dart';

abstract class UseCaseStream<Type, Params> {
  Stream<Result<Type>> call(Params params);
}
