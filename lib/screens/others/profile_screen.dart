
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_bloc.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_event.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_state.dart';
import 'package:mobilestore/screens/auth/login_screen.dart';
import 'package:mobilestore/utils/status.dart';
import 'package:mobilestore/widgets/custom_button_widget.dart';
import 'package:mobilestore/widgets/custom_text_widget.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(),
        child: _ProfileProviderScreen()
    );
  }

}

class _ProfileProviderScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<_ProfileProviderScreen> {
  late TextEditingController _nameController, _phoneController, _addressController;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetUserData());
    _nameController = TextEditingController(text: '');
    _phoneController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white
      ),
        body: SafeArea(
            child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if(state.status == Status.loaded) {
                    _nameController = TextEditingController(text: state.user?.name);
                    _phoneController = TextEditingController(text: state.user?.phone);
                    _addressController = TextEditingController(text: state.user?.address);
                    //reset the state status
                    context.read<ProfileBloc>().add(ResetState());
                  }
                  else if(state.status == Status.failed) {
                    toastMessage(state.message, context);
                    //reset the state status
                    context.read<ProfileBloc>().add(ResetState());
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 54.0, left: 18.0, right: 18.0),
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                  'assets/images/user.png',
                                  width: 100.0,
                                  height: 100.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              customTextWidget(
                                  label: state.user?.email ?? 'Email: N/A',
                                  size: 14,
                                  weight: FontWeight.normal,
                                  textColor: Theme.of(context).colorScheme.onSurface
                              ),
                              const SizedBox(height: 42.0),
                              Container(
                                alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                child: GestureDetector(
                                  onTap: () => context.read<ProfileBloc>().add(EditProfile()),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          'Edit info',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.secondary
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Icon(
                                          Icons.edit,
                                          size: 18,
                                          color: Theme.of(context).colorScheme.secondary
                                      )
                                    ],
                                  ),
                                )
                              ),
                              usableTextFieldWidget(
                                  controller: _nameController,
                                  isEnabled: state.isEditing,
                                  labelHint: 'Full Name',
                                  inputType: TextInputType.text,
                                  onChange: (value) {
                                    context.read<ProfileBloc>().add(NameChange(value));
                                  }
                              ),
                              const SizedBox(height: 14.0),
                              usableTextFieldWidget(
                                  controller: _phoneController,
                                  isEnabled: state.isEditing,
                                  labelHint: 'Phone Number',
                                  inputType: TextInputType.phone,
                                  onChange: (value) => context.read<ProfileBloc>().add(PhoneChange(value))
                              ),
                              const SizedBox(height: 14.0),
                              usableTextFieldWidget(
                                  controller: _addressController,
                                  isEnabled: state.isEditing,
                                  labelHint: 'Address',
                                  inputType: TextInputType.streetAddress,
                                  onChange: (value) => context.read<ProfileBloc>().add(AddressChange(value))
                              ),
                              const SizedBox(height: 18.0),
                              customButtonWidget(
                                  label: 'Save Update',
                                  onClick: () => context.read<ProfileBloc>().add(SubmitEdit()),
                                  isActive: state.isEditing,
                                  context: context
                              )
                            ]
                        )
                      )
                  );
                })
        )
    );
  }


  Widget usableTextFieldWidget({
    required TextEditingController controller,
    required bool isEnabled,
    required String labelHint,
    required TextInputType inputType,
    required Function(String value) onChange
  }) {
    return TextField(
        controller: controller,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintText: labelHint,
            filled: true,
            enabled: isEnabled,
            fillColor: Theme.of(context).colorScheme.surfaceTint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    width: 0.01
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    width: 0.01
                )
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    width: 0.01
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1.0
                )
            )
        ),
        onChanged: (value) => onChange(value)
    );
  }

}