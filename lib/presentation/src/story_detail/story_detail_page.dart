import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'story_detail_vm.dart';
import 'story_detail_state.dart';

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
        WrapState<StoryDetailState>>> {
  @override
  AutoDisposeStateNotifierProvider<StoryDetailVM, WrapState<StoryDetailState>>
      get provider => storyDetailVMProvider(widget.id);

  @override
  Widget buildPage(BuildContext context) {
    final story = ref.watch(provider.select((value) => value.data.story));
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (story != null)
                Padding(
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: Text(
                    story.story,
                    style: TextStyle(
                      fontSize: 20,
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
