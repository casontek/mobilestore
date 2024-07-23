
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BlocConsumer(
                listener: (context, state) {

                },
                builder: (context, state) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                'assets/images/user.png',
                                width: 60.0,
                                height: 60.0,
                              ),
                            ),
                            customTextWidget(
                                label: '',
                                size: 14,
                                weight: FontWeight.normal,
                                textColor: Theme.of(context).colorScheme.onSurface
                            )
                          ]
                      )
                  );
                })
        )
    );
  }

}