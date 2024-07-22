
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/register_bloc/register_bloc.dart';
import 'package:mobilestore/bloc/register_bloc/register_event.dart';
import 'package:mobilestore/bloc/register_bloc/register_state.dart';

import '../../utils/status.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_widget.dart';
import '../../widgets/text_label_button.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreen();

}

class _SignUpScreen extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.surface,
            statusBarIconBrightness: Brightness.dark
        ));
    return BlocProvider(
        create: (context) => RegisterBloc(),
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
                child: BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if(state.status == Status.success) {
                        Navigator.pushReplacementNamed(context, 'login');
                      }
                      else if(state.status == Status.failed) {
                        //show error message
                        toastMessage(state.message, context);
                        context.read<RegisterBloc>().add(RegisterReset());
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customTextWidget(
                                        label: 'Create an Account',
                                        size: 24,
                                        weight: FontWeight.w600,
                                        textColor: Theme.of(context).colorScheme.primary
                                    ),
                                    const SizedBox(height: 14.0),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: 'Email',
                                          filled: true,
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
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context).colorScheme.outlineVariant,
                                                  width: 1.0
                                              )
                                          )
                                      ),
                                      validator: (value) => state.validateEmail(),
                                      onChanged: (value) => context.read<RegisterBloc>().add(EmailChange(value))
                                    ),
                                    const SizedBox(height: 14.0),
                                    TextFormField(
                                      keyboardType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          filled: true,
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
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context).colorScheme.outlineVariant,
                                                  width: 1.0
                                              )
                                          )
                                      ),
                                      validator: (value) => state.validatePassword(),
                                      onChanged: (value) => context.read<RegisterBloc>().add(PasswordChange(value))
                                    ),
                                    const SizedBox(height: 14.0),
                                    TextFormField(
                                      keyboardType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                          filled: true,
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
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context).colorScheme.outlineVariant,
                                                  width: 1.0
                                              )
                                          )
                                      ),
                                      validator: (value) => state.validateConfirmPassword(),
                                      onChanged: (value) => context.read<RegisterBloc>().add(ConfirmPasswordChange(value))
                                    ),
                                    const SizedBox(height: 32.0),
                                    customButtonWidget(
                                        label: 'Sign Up',
                                        isLoading: false,
                                        isActive: true,
                                        context: context,
                                        onClick: () {
                                          if(_formKey.currentState?.validate() == true) {
                                            context.read<RegisterBloc>().add(RegisterUser(state.email, state.password));
                                          }
                                        }
                                    ),
                                    const Spacer(),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          customTextWidget(
                                              label: 'Already have an account?',
                                              size: 16,
                                              weight: FontWeight.w400,
                                              textColor: Theme.of(context).colorScheme.onSurface
                                          ),
                                          const SizedBox(width: 8.0),
                                          textButtonWidget(
                                              label: 'Sign In',
                                              context: context,
                                              onClick: ()  => Navigator.pushNamed(context, 'login')
                                          )
                                        ]
                                    ),
                                    const SizedBox(height: 8.0)
                                  ]
                              )
                          )
                      );
                    })
            )
        )
    );
  }

}