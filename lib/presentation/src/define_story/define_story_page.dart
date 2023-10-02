import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bedtime_stories/core/core.dart';

import 'define_story_state.dart';
import 'define_story_vm.dart';

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
    final charactors = useState<List>(['']);

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
        title: const Text(
          "Define your story",
          style: TextStyle(
            fontSize: Dimens.d30,
            fontFamily: 'circe',
            fontWeight: FontWeight.w700,
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
                        const SizedBox(
                          height: Dimens.d20,
                        ),
                        _buildTitle(
                          'Child\'s name',
                        ),
                        const SizedBox(
                          height: Dimens.d10,
                        ),
                        DynamicTextfield(
                          key: UniqueKey(),
                          hintText: "Alex",
                          onChanged: (v) {},
                        ),
                        const SizedBox(
                          height: Dimens.d20,
                        ),
                        _buildTitle(
                          'Child\' age: ${age.value.round() + 1} years',
                        ),
                        const SizedBox(
                          height: Dimens.d5,
                        ),
                        Slider(
                          value: age.value.roundToDouble(),
                          max: 9,
                          divisions: 9,
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
                          key: UniqueKey(),
                          hintText: "e.g. in a castle, on Mars",
                          onChanged: (v) {},
                        ),
                        const SizedBox(
                          height: Dimens.d20,
                        ),
                        _buildTitle(
                          'Additional charactors:',
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
                        _buildCharactors(charactors),
                        if (charactors.value.length < 5) ...[
                          const SizedBox(
                            height: Dimens.d10,
                          ),
                          _buildButtonAddCharactors(charactors),
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
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // TODO: Navigate to next page
                      // TODO: Save data to state
                    }
                  },
                  child: const Text('Next'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Center _buildButtonAddCharactors(
    ValueNotifier<List<dynamic>> charactors,
  ) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          charactors.value = List.from(
            [...charactors.value, ''],
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

  ListView _buildCharactors(ValueNotifier<List<dynamic>> charactors) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: charactors.value.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            child: DynamicTextfield(
              key: UniqueKey(),
              initialValue: charactors.value[index],
              onChanged: (v) => charactors.value[index] = v,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            constraints: const BoxConstraints(),
            color: AppColors.darkBlue,
            padding: EdgeInsets.zero,
            onPressed: () {
              charactors.value = List.from(charactors.value)..removeAt(index);
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
          String title(index) {
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

          return ChoiceChip(
            selectedColor: AppColors.darkBlue,
            label: Text(
              title(index),
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
