import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'history_vm.dart';
import 'history_state.dart';

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
                        const Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: Dimens.d18,
                              fontFamily: 'circe',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for a story",
                            ),
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
                child: Column(
                  children: [
                    storyWidget(
                      "Title: The Little Red Riding Hood",
                      "September 18, 2023 at 10:00 AM",
                      "Once upon a time, in a cozy living room, Luffy, a courageous young boy with a heart full of determination, prepared for an extraordinary adventure. He put on his red pirate hat, donned his straw sandals, and tightly clenched his beloved rubber fist. ",
                    ),
                    storyWidget(
                      "Title: The Little Red Riding Hood",
                      "September 18, 2023 at 10:00 AM",
                      "Once upon a time, in a cozy living room, Luffy, a courageous young boy with a heart full of determination, prepared for an extraordinary adventure. He put on his red pirate hat, donned his straw sandals, and tightly clenched his beloved rubber fist. ",
                    ),
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
    String title,
    String date,
    String content,
  ) {
    return InkWell(
      onTap: openStoryPage,
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
                    title,
                    style: const TextStyle(
                      fontSize: Dimens.d19,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

  void openStoryPage() {
    // TODO implement open StoryPage
  }
}
