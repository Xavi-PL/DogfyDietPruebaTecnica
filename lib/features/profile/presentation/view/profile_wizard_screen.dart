import 'package:alert_info/alert_info.dart';
import 'package:dogfy_diet_prueba_tecnica/core/utils/date_utilities.dart';
import 'package:dogfy_diet_prueba_tecnica/core/utils/input_utilities.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/di/profile_module.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_state.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/view/profile_wizard_finish.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/view/profile_wizard_loading.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/view/profile_wizard_step.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_breed_selector_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_date_dropdown_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_input_text_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_more_than_one_dog_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_name_input_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_segmented_selector_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_row_selector.widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_weight_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogProfileWizardScreen extends StatefulWidget {
  const DogProfileWizardScreen({super.key});

  @override
  State<DogProfileWizardScreen> createState() => _DogProfileWizardScreenState();
}

class _DogProfileWizardScreenState extends State<DogProfileWizardScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DogProfileBloc>(),
      child: BlocListener<DogProfileBloc, DogProfileState>(
        listenWhen: (prev, next) =>
            prev.currentStep != next.currentStep ||
            prev.errorMessage != next.errorMessage ||
            prev.finished != next.finished,
        listener: (context, state) {
          if (!_controller.hasClients) {
            return;
          }

          _controller.animateToPage(
            state.currentStep,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );

          if (state.errorMessage.isNotEmpty) {
            AlertInfo.show(
              context: context,
              padding: 96,
              position: MessagePosition.bottom,
              typeInfo: TypeInfo.error,
              icon: Icons.error_rounded,
              text: state.errorMessage,
            );
            BlocProvider.of<DogProfileBloc>(context).add(ClearErrorMessage());
          }
        },
        child: BlocBuilder<DogProfileBloc, DogProfileState>(
          builder: (context, state) {
            if (state.ready && !_controller.hasClients) {
              _controller = PageController(initialPage: state.currentStep);
            }

            List<Widget> steps = state.ready ? buildSteps(context, state) : [];

            return Scaffold(
              appBar: AppBar(
                title: state.ready && !state.finished
                    ? LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(360),
                        value: (state.currentStep + 1) / steps.length,
                        color: const Color(0xffffd44a),
                      )
                    : SizedBox(),
                leading: state.currentStep > 0
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          BlocProvider.of<DogProfileBloc>(
                            context,
                          ).add(PreviousStep());
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        },
                      )
                    : null,
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: state.ready
                    ? state.finished
                          ? const ProfileWizardFinish()
                          : PageView(controller: _controller, children: steps)
                    : const ProfileWizardLoading(),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildSteps(BuildContext context, DogProfileState state) {
    return [
      buildDogBreedStep(context, state),
      buildDogNameStep(context, state),
      buildDogGenderAndSterilizedStep(context, state),
      buildDogBirthDateStep(context, state),
      buildDogSizeAndWeightStep(context, state),
      buildDogActivityStep(context, state),
      buildDogIllnessesStep(context, state),
      buildDogGatronomicStep(context, state),
      buildOwnerStep(context, state),
    ];
  }

  Widget buildDogBreedStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '🐶',
      state: state,
      title: '¿Cuál es la raza de tu perrete?',
      content: [
        ProfileBreedSelectorWidget(
          selectedBreed: state.dogProfile!.breed?.name,
          onBreedSelected: (breed) =>
              BlocProvider.of<DogProfileBloc>(context).add(
                BreedSelected(
                  breed: state.availableBreeds.firstWhere(
                    (e) => e.name == breed,
                  ),
                ),
              ),
          availableBreeds: state.availableBreeds
              .map((e) => e.name ?? "")
              .toList(),
        ),
      ],
    );
  }

  Widget buildDogNameStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '✏️',
      state: state,
      title: '¿Cómo se llama tu perrete?',
      description:
          '¡Qué emoción! Estás a punto de mejorar la vida de tu perrete a través de una alimentación 100% natural.',
      content: [
        ProfileNameInputWidget(
          name: state.dogProfile?.name ?? '',
          onNameChanged: (dogName) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogNameSet(dogName: dogName)),
        ),
        SizedBox(height: 20),
        ProfileMoreThanOneDogWidget(),
      ],
    );
  }

  Widget buildDogGenderAndSterilizedStep(
    BuildContext context,
    DogProfileState state,
  ) {
    return DogProfileWizardStep(
      emoji: '🧐',
      title: '¡Queremos conocer a ${state.dogProfile?.name}!',
      description:
          '¿Por qué es importante? Después de la esterilización, se requieren ajustes en la ración, ya que el perro suele tener menor gasto calórico.',
      content: [
        ProfileSegmentedSelectorWidget(
          selected: state.dogProfile?.sex,
          options: [
            ProfileSegmentedSelectorOption(value: DogSex.male, label: 'Macho'),
            ProfileSegmentedSelectorOption(
              value: DogSex.female,
              label: 'Hembra',
            ),
          ],
          onOptionSelected: (option) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogSexSet(sex: option!)),
        ),
        SizedBox(height: 30),
        Center(
          child: Text(
            state.dogProfile?.sex != null
                ? state.dogProfile!.sex == DogSex.male
                      ? '¿Está esterilizado?'
                      : '¿Está esterilizada?'
                : '¿Está esterilizado/a?',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 15),

        ProfileSegmentedSelectorWidget(
          selected: state.dogProfile?.sterilized,
          options: [
            ProfileSegmentedSelectorOption(value: true, label: 'Sí'),
            ProfileSegmentedSelectorOption(value: false, label: 'No'),
          ],
          onOptionSelected: (option) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogSterilizedSet(sterilized: option!)),
        ),
      ],
      state: state,
    );
  }

  Widget buildDogBirthDateStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '🎂',
      title: '¿Cuándo nació ${state.dogProfile?.name}?',
      content: [
        ProfileDateDropdownWidget(
          hint: 'Año',
          selectedValue: state.dogProfile?.birthYear,
          options: List.generate(
            DateTime.now().year - 2006 + 1,
            (index) => index + 2006,
          ).reversed.toList(),
          onDateSelected: (year) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogBirthYearSelected(year: year)),
        ),
        SizedBox(height: 16),
        ProfileDateDropdownWidget(
          hint: 'Mes',
          selectedValue: DateUtilities.getMonthName(
            state.dogProfile?.birthMonth,
          ),
          options: DateUtilities.getMonthNames(),
          onDateSelected: (month) =>
              BlocProvider.of<DogProfileBloc>(context).add(
                DogBirthMonthSelected(
                  month: DateUtilities.getMonthIndex(month),
                ),
              ),
        ),
      ],
      state: state,
    );
  }

  Widget buildDogSizeAndWeightStep(
    BuildContext context,
    DogProfileState state,
  ) {
    return DogProfileWizardStep(
      title: '¿Qué silueta representa mejor a ${state.dogProfile?.name}?',
      content: [
        ProfileRowSelectorWidget(
          options: [
            ProfileRowSelectorOption(
              option: DogSize.small,
              label: 'small',
              description:
                  'Un poco flaquito: Cintura estrecha y se le ven claramente las costillas.',
              asset: 'dog_size_small.png',
            ),
            ProfileRowSelectorOption(
              option: DogSize.medium,
              label: 'medium',
              description:
                  'Hecho un figurín: La cintura es visible y sus costillas son fáciles de palpar.',
              asset: 'dog_size_medium.png',
            ),
            ProfileRowSelectorOption(
              option: DogSize.big,
              label: 'big',
              description:
                  'Un poco rellenito: La cintura no es visible y sus costillas son difíciles de palpar.',
              asset: 'dog_size_big.png',
            ),
          ],
          selected: state.dogProfile?.size,
          onSelected: (size) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogSizeSet(size: size)),
        ),
        SizedBox(height: 40),
        ProfileWeightInputWidget(
          currentWeight: state.dogProfile?.weight,
          onWeightChanged: (weight) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogWeightSet(weight: weight)),
        ),
      ],
      state: state,
    );
  }

  Widget buildDogActivityStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      title: '¿Cuál es el nivel de actividad de ${state.dogProfile?.name}?',
      content: [
        ProfileRowSelectorWidget(
          options: [
            ProfileRowSelectorOption(
              option: DogActivity.low,
              label: 'low',
              description:
                  'Perro alfombra: paseos diarios de menos de 1h. Lo que más le gusta es echarse una buena siesta  y estar bien tranquilito.',
              asset: 'dog_activity_low.png',
            ),
            ProfileRowSelectorOption(
              option: DogActivity.medium,
              label: 'medium',
              description:
                  'Perro zen: paseos diarios de 1 a 2h. Sabe disfrutar de buenas caminatas, pero también sabe cuándo descansar.',
              asset: 'dog_activity_medium.png',
            ),
            ProfileRowSelectorOption(
              option: DogActivity.high,
              label: 'high',
              description:
                  'Perro terremoto: paseos diarios de más de 2h. ¡No veas qué torbellino de energía!',
              asset: 'dog_activity_high.png',
            ),
          ],
          onSelected: (activity) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogActivitySet(activity: activity)),
          selected: state.dogProfile?.activity,
        ),
      ],
      state: state,
    );
  }

  Widget buildDogIllnessesStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '❤️‍🩹',
      title: '¿Tiene ${state.dogProfile?.name} alguna patología?',
      description:
          'Cada perro es un mundo. ¡No te preocupes! Adaptaremos nuestro menú a su caso, siempre que sea posible. Si la patología de tu perro no aparece en el formulario, envía un correo a nutricionistas@dogfydiet.com.',
      content: [
        ProfileSegmentedSelectorWidget(
          selected: state.dogProfile?.hasIllness,
          options: [
            ProfileSegmentedSelectorOption(value: true, label: 'Sí'),
            ProfileSegmentedSelectorOption(value: false, label: 'No'),
          ],
          onOptionSelected: (option) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogHasIllnessSet(hasIllness: option!)),
        ),
      ],
      state: state,
    );
  }

  Widget buildDogGatronomicStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      title: '¿Qué crítico gastronómico es tu perro?',
      content: [
        ProfileRowSelectorWidget(
          options: [
            ProfileRowSelectorOption(
              option: DogGastronomy.selective,
              label: 'selective',
              description:
                  'El selectivo: es de paladar exigente, suele costarle terminar su ración y se cansa de la comida (verás qué cambio cuando pruebe Dogfy)',
              asset: 'dog_gastronomy_selective.png',
            ),
            ProfileRowSelectorOption(
              option: DogGastronomy.gourmet,
              label: 'gourmet',
              description:
                  'El gourmet: le encanta probar nuevos sabores, pero no se conforma con cualquier cosa',
              asset: 'dog_gastronomy_gourmet.png',
            ),
            ProfileRowSelectorOption(
              option: DogGastronomy.none,
              label: 'none',
              description:
                  'El glotón: devora todo tipo de comida como si no fuera a probar bocado nunca más',
              asset: 'dog_gastronomy_none.png',
            ),
          ],
          onSelected: (gastronomy) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogGastronomySet(gastronomy: gastronomy)),
          selected: state.dogProfile?.gastronomy,
        ),
      ],
      state: state,
    );
  }

  Widget buildOwnerStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '👍',
      title:
          '¡El menú especial para ${state.dogProfile?.name} está casi listo!',
      content: [
        ProfileInputTextWidget(
          value: state.dogProfile?.owner?.name ?? '',
          icon: Icons.person,
          onChanged: (ownerName) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogOwnerNameSet(ownerName: ownerName)),
          label: 'Nombre',
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        ),
        SizedBox(height: 12),
        ProfileInputTextWidget(
          value: state.dogProfile?.owner?.email ?? '',
          icon: Icons.email,
          onChanged: (ownerEmail) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogOwnerEmailSet(ownerEmail: ownerEmail)),
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          inputFormatters: InputUtilities.emailInputFormatters(),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              flex: 4,
              child: DropdownMenu(
                hintText: "País",
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: Country.es, label: 'España'),
                  DropdownMenuEntry(value: Country.fr, label: 'Francia'),
                  DropdownMenuEntry(value: Country.it, label: 'Italia'),
                  DropdownMenuEntry(value: Country.de, label: 'Alemania'),
                ],
                onSelected: (country) => BlocProvider.of<DogProfileBloc>(
                  context,
                ).add(DogOwnerCountrySet(ownerCountry: country!)),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 6,
              child: ProfileInputTextWidget(
                value: state.dogProfile?.owner?.phone ?? '',
                onChanged: (ownerPhone) => BlocProvider.of<DogProfileBloc>(
                  context,
                ).add(DogOwnerPhoneSet(ownerPhone: ownerPhone)),
                label: 'Teléfono',
                keyboardType: TextInputType.phone,
                inputFormatters: InputUtilities.phoneInputFormatters(),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ProfileInputTextWidget(
                value: state.dogProfile?.owner?.address ?? '',
                onChanged: (ownerAddress) => BlocProvider.of<DogProfileBloc>(
                  context,
                ).add(DogOwnerAddressSet(ownerAddress: ownerAddress)),
                label: 'Dirección',
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: state.isLoadingAddress
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location_rounded),
                onPressed: () => BlocProvider.of<DogProfileBloc>(
                  context,
                ).add(GetAddressEvent()),
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      description:
          'Al continuar, se guardará tu proceso y estarás aceptando los términos y condiciones y la política de privacidad para recibir las mejores recomendaciones sobre alimentación.',
      state: state,
    );
  }
}
