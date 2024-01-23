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
    emitData(
      dataState.copyWith(
        text: 'Generating Image...\nPlease wait a moment.',
      ),
    );
    await runCatching(
      saveStoryLocalUsecase.call(SaveStoryLocalParams(story: event.story)),
      doOnSuccess: (id) {
        navigator.popAndPush(StoryDetailRoute(id: id));
      },
    );
  }

  Future<void> onDefineStoryEventOnPressed(
    DefineStoryEventOnPressed event,
  ) async {
    final storyPrompts = [
      'Please write me a short ${event.language} story.',
      'In this story, ${event.childName} is the main character, is ${event.age}-year-old and ${event.gender}.',
      'The story takes place at ${event.venue} with the following characters: ${event.characters.join(', ')}.',
      'First content is story title and have the words \'Title:\' at the start.',
      'After story title, write me an image prompt for an AI image generator and have the words \'Image Prompt:\' at the start.',
      'Choose a book illustrator and put something in the image prompt to say the image should be made in the style of that artist.',
    ];
    final storyPrompt = storyPrompts.join(' ');
    emitData(dataState.copyWith(loading: true));
    runCatchingStream(
      completionUsecase.call(
        CompletionParams(
          messages: [
            const Message(
              content: "You are a children's author.",
              role: 'system',
            ),
            Message(
              role: 'user',
              content: storyPrompt,
            )
          ],
        ),
      ),
      isHandleLoading: false,
      doOnCompleleted: () {
        emitData(dataState.copyWith(loading: false));
      },
      doOnError: (error) {
        emitData(dataState.copyWith(loading: false));
      },
      doOnSuccess: (data) {
        emitData(
          dataState.copyWith(
            text: (dataState.text ?? "") + data.story,
          ),
        );
        if (data.isStop == true) {
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
