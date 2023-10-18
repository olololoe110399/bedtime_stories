import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:bedtime_stories/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class HistoryPage extends StatefulHookConsumerWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _PageState();
}

class _PageState extends BasePageState<HistoryPage, HistoryState,
    AutoDisposeStateNotifierProvider<HistoryVM, WrapState<HistoryState>>> {
  @override
  AutoDisposeStateNotifierProvider<HistoryVM, WrapState<HistoryState>>
      get provider => historyVMProvider;

  @override
  Widget buildPage(BuildContext context) {
    final stories = ref.watch(
      provider.select(
        (value) => value.data.stories
            .where(
              (element) => value.data.searchKey.isEmpty
                  ? true
                  : element.title
                      .toLowerCase()
                      .contains(value.data.searchKey.toLowerCase()),
            )
            .toList(),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: Column(
        children: [
          Container(
            height: mediaQueryData.size.height * 0.3,
            width: mediaQueryData.size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/searchBg.png"),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(Dimens.d20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: Dimens.d16,
                      fontFamily: 'circe',
                    ),
                  ),
                  const Text(
                    "My Stories",
                    style: TextStyle(
                      fontSize: Dimens.d30,
                      fontFamily: 'circe',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: Dimens.d70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Dimens.d20,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: Dimens.d30,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              fontSize: Dimens.d18,
                              fontFamily: 'circe',
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for a story",
                            ),
                            onChanged: (value) {
                              ref
                                  .read(provider.notifier)
                                  .add(HistoryEvent.searchChanged(value));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.d30,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(Dimens.d30),
                width: mediaQueryData.size.width,
                color: Colors.white,
                child: stories.isEmpty
                    ? Column(
                        children: [
                          Lottie.asset(
                            'assets/json/loading.json',
                            height: Dimens.d150,
                          ),
                          const SizedBox(
                            height: Dimens.d8,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.darkBlue,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    18.0,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () =>
                                ref.read(appNavigatorProvider).pop(),
                            child: const Text('Generate'),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ...stories.map(storyWidget),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell storyWidget(
    Story story,
  ) {
    final title = story.title;
    final date =
        story.date?.toStringWithFormat('MMMM dd, yyyy at hh:mm a') ?? 'No date';
    final content = story.story;
    return InkWell(
      onTap: () => openStoryPage(story.id),
      child: Container(
        margin: const EdgeInsets.only(top: Dimens.d20),
        height: Dimens.d200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimens.d30),
          ),
          color: AppColors.primary.withOpacity(0.5),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.d30),
              ),
              child: Container(
                height: Dimens.d125,
                width: Dimens.d150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/iconBgNew.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              padding: const EdgeInsets.all(Dimens.d15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${content.length} words',
                        style: const TextStyle(
                          fontSize: Dimens.d10,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: Dimens.d5,
                  ),
                  Text(
                    title.replaceFirst('Title: ', ""),
                    style: const TextStyle(
                      fontSize: Dimens.d19,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: Dimens.d5,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: Dimens.d13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          content,
                          style: const TextStyle(
                            fontSize: Dimens.d16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openStoryPage(id) {
    ref.read(appNavigatorProvider).push(StoryDetailRoute(id: id));
  }
}
