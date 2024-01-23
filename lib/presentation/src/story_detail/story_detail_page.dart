import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avatar_glow/avatar_glow.dart';

@RoutePage()
class StoryDetailPage extends StatefulHookConsumerWidget {
  const StoryDetailPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  ConsumerState<StoryDetailPage> createState() => _PageState();
}

class _PageState extends BasePageState<
    StoryDetailPage,
    StoryDetailState,
    AutoDisposeStateNotifierProvider<StoryDetailVM,
        WrapState<StoryDetailState>>> with WidgetsBindingObserver {
  @override
  AutoDisposeStateNotifierProvider<StoryDetailVM, WrapState<StoryDetailState>>
      get provider => storyDetailVMProvider(widget.id);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        ref.read(provider.notifier).add(const StoryDetailEvent.stop());
        break;
      default:
        break;
    }
  }

  bool iVailUrl(String url) {
    if (url.isEmpty) {
      return false;
    }
    return [
      'https://',
      'http://',
    ].any((element) => url.startsWith(element));
  }

  @override
  Widget buildPage(BuildContext context) {
    void initLanguages() async {}

    useEffect(() {
      initLanguages();
      WidgetsBinding.instance.addObserver(this);
      return () {
        WidgetsBinding.instance.removeObserver(this);
      };
    }, const []);

    final story = ref.watch(provider.select((value) => value.data.story));

    if (story == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final isSpeaking =
        ref.watch(provider.select((value) => value.data.isSpeaking));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => ref.read(appNavigatorProvider).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: Dimens.d30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(provider.notifier).add(const StoryDetailEvent.shared());
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
              size: Dimens.d30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.d16,
                  left: Dimens.d16,
                  right: Dimens.d16,
                ),
                child: Text(
                  story.title.replaceFirst('Title: ', ''),
                  style: const TextStyle(
                    fontSize: Dimens.d26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),

              AvatarGlow(
                glowColor: AppColors.darkBlue,
                endRadius: 90.0,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                animate: isSpeaking,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: AppColors.darkBlue,
                    radius: 40.0,
                    child: IconButton(
                      onPressed: () {
                        if (isSpeaking) {
                          ref
                              .read(provider.notifier)
                              .add(const StoryDetailEvent.stop());
                        } else {
                          ref
                              .read(provider.notifier)
                              .add(const StoryDetailEvent.play());
                        }
                      },
                      icon: isSpeaking
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.volume_up,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ),
              if (iVailUrl(story.imagePath))
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: Dimens.d16,
                    right: Dimens.d16,
                  ),
                  child: Image.network(
                    story.imagePath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(Dimens.d16),
                child: Text(
                  story.story,
                  style: TextStyle(
                    fontSize: Dimens.d20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
              ),

              // if (story != null)
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Image.network(
              //       story.imagePath ?? '',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
