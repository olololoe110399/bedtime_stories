import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'define_story_event.dart';
import 'define_story_state.dart';

final defineStoryVMProvider = StateNotifierProvider.autoDispose<DefineStoryVM,
    WrapState<DefineStoryState>>(
  (ref) => DefineStoryVM(
    ref,
    completionUsecase: GetIt.instance.get<CompletionUsecase>(),
    initDatabaseStoryUsecase: GetIt.instance.get<InitDatabaseStoryUsecase>(),
    saveStoryLocalUsecase: GetIt.instance.get<SaveStoryLocalUsecase>(),
  ),
);

class DefineStoryVM extends BaseVM<DefineStoryEvent, DefineStoryState> {
  DefineStoryVM(
    Ref ref, {
    required this.completionUsecase,
    required this.initDatabaseStoryUsecase,
    required this.saveStoryLocalUsecase,
  }) : super(const DefineStoryState(), ref) {
    Future.microtask(() {
      add(const DefineStoryEventLoaded());
    });
  }

  CompletionUsecase completionUsecase;
  InitDatabaseStoryUsecase initDatabaseStoryUsecase;
  SaveStoryLocalUsecase saveStoryLocalUsecase;

  @override
  void add(DefineStoryEvent event) {
    switch (event) {
      case DefineStoryEventLoaded event:
        onDefineStoryEventLoaded(event);
        break;
      case DefineStoryEventOnPressed event:
        onDefineStoryEventOnPressed(event);
        break;
      case DefineStoryEventSaveStory event:
        onDefineStoryEventSaveStory(event);
        break;
      default:
    }
  }

  Future<void> onDefineStoryEventLoaded(
    DefineStoryEventLoaded event,
  ) async {
    runCatching(
      initDatabaseStoryUsecase.call(unit),
      isHandleLoading: false,
    );
  }

  Future<void> onDefineStoryEventSaveStory(
    DefineStoryEventSaveStory event,
  ) async {
    await runCatching(
      saveStoryLocalUsecase.call(SaveStoryLocalParams(story: event.story)),
      isHandleLoading: false,
      doOnSuccess: (id) {
        navigator.popAndPush(StoryDetailRoute(id: id));
      },
    );
  }

  Future<void> onDefineStoryEventOnPressed(
    DefineStoryEventOnPressed event,
  ) async {
    final storyPrompt =
        "Please write a short story in ${event.language}. In this event, ${event.childName} is the main character, a ${event.age}-year-old ${event.gender}. The story unfolds at ${event.venue} with the following characters: ${event.characters.join(', ')}. As for the story, create an AI image generator request. This request outlines the overall image, beginning with 'Image Prompt:' at the start. ";
    runCatchingStream(
      completionUsecase.call(
        CompletionParams(messages: [
          Message(
            content:
                'You are children\'s book author. You are writing a story about 500 tokens for ${event.childName}.',
            role: 'system',
          ),
          Message(
            role: 'user',
            content: storyPrompt,
          )
        ]),
      ),
      doOnSuccess: (data) {
        emitData(
          dataState.copyWith(
            text: (dataState.text ?? "") + data.story,
          ),
        );
        if (data.isStop == true) {
          hideLoading();
          add(
            DefineStoryEventSaveStory(
              story: data.copyWith(story: dataState.text ?? ''),
            ),
          );
        }
      },
    );
  }
}
