import 'package:auto_route/auto_route.dart';
import 'package:bedtime_stories/presentation/src/define_story/define_story_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bedtime_stories/core/core.dart';
import 'package:lottie/lottie.dart';

import 'define_story_state.dart';
import 'define_story_vm.dart';

String titleGender(index) {
  switch (index) {
    case 0:
      return 'Boy';
    case 1:
      return 'Girl';
    case 2:
      return 'Diverse';
    default:
      return '';
  }
}

@RoutePage()
class DefineStoryPage extends StatefulHookConsumerWidget {
  const DefineStoryPage({super.key});

  @override
  ConsumerState<DefineStoryPage> createState() => _PageState();
}

class _PageState extends BasePageState<
    DefineStoryPage,
    DefineStoryState,
    AutoDisposeStateNotifierProvider<DefineStoryVM,
        WrapState<DefineStoryState>>> {
  @override
  AutoDisposeStateNotifierProvider<DefineStoryVM, WrapState<DefineStoryState>>
      get provider => defineStoryVMProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildPage(BuildContext context) {
    final age = useState(1.0);
    final gender = useState<int?>(0);
    final characters = useState<List<String>>(['Luffy']);
    final childName = useState('Alex');
    final venue = useState('Wano');
    final language = useState('English');
    final inferenceId = useState('nitrosocke/Arcane-Diffusion');
    final scrollController = useScrollController();

    ref.listen(
      provider.select((value) => value.data.text),
      (prevText, nextText) {
        final loading = ref.read(
          provider.select((value) => value.data.loading),
        );
        if (nextText != null && loading) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      },
    );
    return Stack(
      children: [
        Scaffold(
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
            title: const Text(
              "Define your story",
              style: TextStyle(
                fontSize: Dimens.d26,
                fontWeight: FontWeight.w700,
                fontFamily: 'circe',
                color: AppColors.black,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(Dimens.d20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle(
                              'Child\'s name',
                            ),
                            const SizedBox(
                              height: Dimens.d10,
                            ),
                            DynamicTextfield(
                              hintText: "Alex",
                              initialValue: childName.value,
                              onChanged: (v) => childName.value = v,
                            ),
                            const SizedBox(
                              height: Dimens.d20,
                            ),
                            _buildTitle(
                              'Child\' age: ${age.value.round()} years',
                            ),
                            const SizedBox(
                              height: Dimens.d5,
                            ),
                            Slider(
                              value: age.value.roundToDouble(),
                              min: 1,
                              max: 10,
                              divisions: 10,
                              thumbColor: AppColors.darkBlue,
                              inactiveColor: AppColors.white,
                              activeColor: AppColors.darkBlue,
                              label: age.value.round().toString(),
                              onChanged: (double value) => age.value = value,
                            ),
                            const SizedBox(
                              height: Dimens.d20,
                            ),
                            _buildTitle('Gender:'),
                            const SizedBox(
                              height: Dimens.d5,
                            ),
                            _buildGender(gender),
                            const SizedBox(
                              height: Dimens.d20,
                            ),
                            _buildTitle('Where does the story play?'),
                            const SizedBox(
                              height: Dimens.d10,
                            ),
                            DynamicTextfield(
                              hintText: "e.g. in a castle, on Mars",
                              initialValue: venue.value,
                              onChanged: (v) => venue.value = v,
                            ),
                            const SizedBox(
                              height: Dimens.d20,
                            ),
                            _buildTitle(
                              'Additional characters:',
                            ),
                            const SizedBox(
                              height: Dimens.d5,
                            ),
                            _buildTitle(
                              'Add your child\' favorite characters to the story!',
                              fontSize: Dimens.d12,
                            ),
                            const SizedBox(
                              height: Dimens.d10,
                            ),
                            _buildCharacters(characters),
                            if (characters.value.length < 5) ...[
                              const SizedBox(
                                height: Dimens.d10,
                              ),
                              _buildButtonAddCharacters(characters),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.d20,
                      vertical: Dimens.d10,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        ViewUtils.hideKeyboard(context);
                        if (_formKey.currentState?.validate() ?? false) {
                          ref.read(provider.notifier).add(
                                DefineStoryEvent.onPressed(
                                  age: age.value.round().toString(),
                                  gender: titleGender(gender.value),
                                  characters: characters.value,
                                  childName: childName.value,
                                  venue: venue.value,
                                  language: language.value,
                                  inferenceId: inferenceId.value,
                                ),
                              );
                        }
                      },
                      child: const Text('Next'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: ref.watch(
            provider.select((value) => value.data.loading),
          ),
          child: _buildPageLoading(
            scrollController: scrollController,
          ),
        )
      ],
    );
  }

  Widget _buildPageLoading({
    required ScrollController scrollController,
  }) {
    return Scaffold(
      body: Stack(
        children: [
          const ModalBarrier(
            dismissible: false,
            color: AppColors.primary,
          ),
          Container(
            padding: const EdgeInsets.all(Dimens.d20),
            alignment: Alignment.center,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              shrinkWrap: true,
              children: [
                Lottie.asset(
                  'assets/json/loading.json',
                  height: Dimens.d100,
                ),
                Text(
                  'Generating Story...\nPlease wait a moment.',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: Dimens.d18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: Dimens.d18,
                ),
                Text(
                  ref.watch(
                    provider.select((value) => value.data.text ?? ''),
                  ),
                  style: const TextStyle(
                    fontSize: Dimens.d15,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'circe',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPageLoading() {
    return Scaffold(
      body: Stack(
        children: [
          const ModalBarrier(
            dismissible: false,
            color: AppColors.primary,
          ),
          Container(
            padding: const EdgeInsets.all(Dimens.d20),
            alignment: Alignment.center,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Lottie.asset(
                  'assets/json/loading.json',
                  height: Dimens.d100,
                ),
                Text(
                  ref.watch(
                    provider.select((value) => value.data.text ?? ''),
                  ),
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: Dimens.d18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center _buildButtonAddCharacters(
    ValueNotifier<List<dynamic>> characters,
  ) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          characters.value = List<String>.from(
            [...characters.value, ''],
          );
        },
        icon: Icon(
          Icons.add_circle_rounded,
          color: AppColors.darkBlue,
        ),
        label: Text(
          'Add character',
          style: TextStyle(
            fontSize: Dimens.d18,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w800,
            fontFamily: 'circe',
          ),
        ),
      ),
    );
  }

  ListView _buildCharacters(ValueNotifier<List<dynamic>> characters) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: characters.value.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            child: DynamicTextfield(
              initialValue: characters.value[index],
              onChanged: (v) => characters.value[index] = v,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            constraints: const BoxConstraints(),
            color: AppColors.darkBlue,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (characters.value.length > 1) {
                characters.value = List<String>.from(characters.value)
                  ..removeAt(index);
              }
            },
            icon: const Icon(
              Icons.remove_circle_rounded,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
    );
  }

  Text _buildTitle(title, {double? fontSize = Dimens.d18}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: AppColors.darkBlue,
        fontWeight: FontWeight.w400,
        fontFamily: 'circe',
      ),
    );
  }

  Wrap _buildGender(ValueNotifier<int?> gender) {
    return Wrap(
      spacing: 5.0,
      children: List<Widget>.generate(
        3,
        (int index) {
          return ChoiceChip(
            selectedColor: AppColors.darkBlue,
            label: Text(
              titleGender(index),
              style: const TextStyle(
                fontSize: Dimens.d18,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'circe',
              ),
            ),
            selected: gender.value == index,
            onSelected: (bool selected) => gender.value = index,
          );
        },
      ).toList(),
    );
  }
}

class DynamicTextfield extends HookConsumerWidget {
  final String? initialValue;
  final void Function(String) onChanged;
  final String? hintText;

  const DynamicTextfield({
    super.key,
    this.initialValue,
    this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: initialValue);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimens.d8,
          ),
        ),
        color: AppColors.white,
      ),
      child: TextFormField(
        onChanged: onChanged,
        validator: (v) {
          if (v == null || v.trim().isEmpty) return 'Please enter something';
          return null;
        },
        controller: controller,
        style: const TextStyle(
          fontSize: Dimens.d18,
          fontFamily: 'circe',
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimens.d8,
            ),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimens.d8,
            ),
            borderSide: const BorderSide(
              color: AppColors.error,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimens.d8,
            ),
            borderSide: BorderSide(
              color: AppColors.darkBlue,
            ),
          ),
          hintText: hintText ?? "Enter somthing",
        ),
      ),
    );
  }
}
