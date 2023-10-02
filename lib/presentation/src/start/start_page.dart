import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'start_vm.dart';
import 'start_state.dart';

@RoutePage()
class StartPage extends StatefulHookConsumerWidget {
  const StartPage({super.key});

  @override
  ConsumerState<StartPage> createState() => _PageState();
}

class _PageState extends BasePageState<StartPage, StartState,
    AutoDisposeStateNotifierProvider<StartVM, WrapState<StartState>>> {
  @override
  AutoDisposeStateNotifierProvider<StartVM, WrapState<StartState>>
      get provider => startVMProvider;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/splash.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "WHERE KIDS LOVE STORIES",
                    style: TextStyle(
                      fontSize: Dimens.d12,
                      fontFamily: 'circe',
                    ),
                  ),
                  const Text(
                    "Bedtime Stories",
                    style: TextStyle(
                      fontSize: Dimens.d26,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'circe',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Create magical and unique stories\nfor your child based on their \nfavorite characters. Everiy night is\n a new adventure.",
                    style: TextStyle(
                      fontSize: Dimens.d15,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'circe',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: Dimens.d15,
                            color: Colors.black.withOpacity(0.1),
                          )),
                      child: Container(
                        padding: const EdgeInsets.all(Dimens.d5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.darkBlue,
                        ),
                        child: IconButton(
                          onPressed: () => ref.read(appRouterProvider).push(
                                const DefineStoryRoute(),
                              ),
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => ref.read(appNavigatorProvider).push(
                          const HistoryRoute(),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "View preview stories",
                          style: TextStyle(
                            fontSize: Dimens.d15,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'circe',
                            color: AppColors.darkBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: Dimens.d10,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: AppColors.darkBlue,
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: Dimens.d18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'circe',
                            color: AppColors.darkBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: Dimens.d5,
                        ),
                        Image.asset(
                          'assets/img/palette.png',
                          width: Dimens.d20,
                          height: Dimens.d20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
