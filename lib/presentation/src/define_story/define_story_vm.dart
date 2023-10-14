import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'define_story_event.dart';
import 'define_story_state.dart';

final defineStoryVMProvider = StateNotifierProvider.autoDispose<DefineStoryVM,
    WrapState<DefineStoryState>>(
  (ref) => DefineStoryVM(
    ref,
    completionUsecase: GetIt.I.get<CompletionUsecase>(),
  ),
);

class DefineStoryVM extends BaseVM<DefineStoryEvent, DefineStoryState> {
  DefineStoryVM(
    Ref ref, {
    required this.completionUsecase,
  }) : super(const DefineStoryState(), ref);

  CompletionUsecase completionUsecase;

  @override
  void add(DefineStoryEvent event) {
    switch (event) {
      case DefineStoryEventLoaded event:
        onDefineStoryEventLoaded(event);
      case DefineStoryEventOnPressed event:
        onDefineStoryEventOnPressed(event);
        // Add More Event here
        break;
      default:
    }
  }

  Future<void> onDefineStoryEventLoaded(
    DefineStoryEventLoaded event,
  ) async {
    // TODO: Implement DefineStoryEventLoaded
  }

  Future<void> onDefineStoryEventOnPressed(
    DefineStoryEventOnPressed event,
  ) async {
    final storyPrompt =
        "Please write a short story in ${event.language}. In this event, ${event.childName} is the main character, a ${event.age}-year-old ${event.gender}. The story unfolds at ${event.venue} with the following characters: ${event.characters.join(', ')}. As for the story, create an AI image generator request. This request outlines the overall image, beginning with 'Image Prompt:' at the start. ";

    runCatching<ChatCompletion>(
      completionUsecase.call(
        CompletionParams(messages: [
          Message(
            content:
                'You are children\'s book author. You are writing a story about ${event.childName}.',
            role: 'system',
          ),
          Message(
            role: 'user',
            content: storyPrompt,
          )
        ]),
      ),
      doOnSuccess: (data) {
        logD(data);
        navigator.showSuccessSnackBar(message: data.choices[0].message.content);
      },
    );
  }
}
