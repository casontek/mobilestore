
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/login_bloc/login_bloc.dart';
import 'package:mobilestore/bloc/login_bloc/login_event.dart';
import 'package:mobilestore/bloc/login_bloc/login_state.dart';

import '../../utils/status.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_widget.dart';
import '../../widgets/text_label_button.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();

}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
              child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if(state.status == Status.success) {
                      Navigator.pushReplacementNamed(context, 'listing');
                    }
                    else if(state.status == Status.failed) {
                      //show error message
                      toastMessage(state.message, context);
                      context.read<LoginBloc>().add(ResetLogin());
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
                                      label: 'Account Login',
                                      size: 24,
                                      weight: FontWeight.w600,
                                      textColor: Theme.of(context).colorScheme.primary
                                  ),
                                  const SizedBox(height: 32.0),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
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
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    obscureText: state.hidePassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        filled: true,
                                        suffixIcon: GestureDetector(
                                            child: Icon(
                                                state.hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                            onTap: () => context.read<LoginBloc>().add(PasswordVisibilityEvent())
                                        ),
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
                                  ),
                                  const SizedBox(height: 24.0),
                                  textButtonWidget(
                                      label: 'Forgot Password?',
                                      context: context,
                                      onClick: () {}
                                  ),
                                  const SizedBox(height: 24.0),
                                  customButtonWidget(
                                      label: 'Sign In',
                                      isLoading: false,
                                      context: context,
                                      onClick: () {
                                        if(_formKey.currentState?.validate() == true) {

                                        }
                                      }
                                  ),
                                  const Spacer(),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customTextWidget(
                                            label: 'Don’t have an account?',
                                            size: 16,
                                            weight: FontWeight.w400,
                                            textColor: Theme.of(context).colorScheme.onSurface
                                        ),
                                        const SizedBox(width: 8.0),
                                        textButtonWidget(
                                            label: 'Sign Up',
                                            context: context,
                                            onClick: () => Navigator.pushNamed(context, 'register')
                                        )
                                      ]
                                  ),
                                  const SizedBox(height: 8.0)
                                ]
                            )
                        )
                    );
                  }
              )
          ),
        )
    );
  }

}

void toastMessage(String message, BuildContext c) {
  ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
}