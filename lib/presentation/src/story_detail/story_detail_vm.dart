import 'dart:async';

import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'story_detail_event.dart';
import 'story_detail_state.dart';

final storyDetailVMProvider = StateNotifierProvider.autoDispose
    .family<StoryDetailVM, WrapState<StoryDetailState>, String>((ref, id) {
  final flutterTts = FlutterTts();
  return StoryDetailVM(
    ref,
    id: id,
    getStoryByIdUsecase: GetIt.instance.get<GetStoryByIdUsecase>(),
    flutterTts: flutterTts,
  );
});

class StoryDetailVM extends BaseVM<StoryDetailEvent, StoryDetailState> {
  StoryDetailVM(
    Ref ref, {
    required this.id,
    required this.getStoryByIdUsecase,
    required this.flutterTts,
  }) : super(const StoryDetailState(), ref) {
    Future.microtask(
      () {
        add(const StoryDetailEventLoaded());
      },
    );
  }

  String id;

  FlutterTts flutterTts;

  GetStoryByIdUsecase getStoryByIdUsecase;

  @override
  void add(StoryDetailEvent event) {
    switch (event) {
      case StoryDetailEventLoaded event:
        onStoryDetailEventLoaded(event);
        break;
      case StoryDetailEventShared event:
        onStoryDetailEventShared(event);
        break;
      case StoryDetailEventPlay event:
        onStoryDetailEventPlay(event);
        break;
      case StoryDetailEventStoped event:
        onStoryDetailEventStoped(event);
        break;
      default:
    }
  }

  Future<void> onStoryDetailEventLoaded(
    StoryDetailEventLoaded event,
  ) async {
    await runCatching(
      getStoryByIdUsecase.call(GetStoryByIdParams(id: id)),
      doOnSuccess: (story) async {
        emitData(
          dataState.copyWith(
            languages: List<String>.from(await flutterTts.getLanguages),
          ),
        );
        emitData(dataState.copyWith(story: story));
      },
    );
  }

  Future<void> onStoryDetailEventShared(
    StoryDetailEventShared event,
  ) async {
    navigator.shareWithResult(dataState.story?.story ?? '');
  }

  Future<void> onStoryDetailEventPlay(
    StoryDetailEventPlay event,
  ) async {
    await flutterTts.setVolume(dataState.volume);
    await flutterTts.setPitch(dataState.pitch);
    await flutterTts.setSpeechRate(dataState.speechRate);
    await flutterTts.setLanguage(dataState.langCode);
    await flutterTts.setVoice({"name": "Karen", "locale": dataState.langCode});
    emitData(
      dataState.copyWith(
        isSpeaking: true,
      ),
    );
    await flutterTts.speak(dataState.story?.story ?? '');
  }

  Future<void> onStoryDetailEventStoped(
    StoryDetailEventStoped event,
  ) async {
    emitData(
      dataState.copyWith(
        isSpeaking: false,
      ),
    );
    await flutterTts.stop();
  }

  @override
  void dispose() async {
    await flutterTts.stop();
    super.dispose();
  }
}
