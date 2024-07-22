
import 'package:flutter/material.dart';

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
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
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
                          obscureText: _hidePassword,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              suffixIcon: GestureDetector(
                                  child: Icon(
                                      _hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                  onTap: () {
                                    setState(() {
                                      _hidePassword = !_hidePassword;
                                    });
                                  }
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
                                  onClick: () {

                                  }
                              )
                            ]
                        ),
                        const SizedBox(height: 8.0)
                      ]
                  )
              )
          )
      ),
    );
  }

}