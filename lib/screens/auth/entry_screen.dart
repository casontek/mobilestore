
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/entry_bloc/entry_bloc.dart';
import 'package:mobilestore/bloc/entry_bloc/entry_event.dart';
import 'package:mobilestore/bloc/entry_bloc/entry_state.dart';

class EntryScreen extends StatelessWidget {

  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EntryBloc(),
        child: const _EntryScreenProvider()
    );
  }

}

class _EntryScreenProvider extends StatefulWidget {

  const _EntryScreenProvider();

  @override
  State<StatefulWidget> createState() => _EntryScreen();

}

class _EntryScreen extends State<_EntryScreenProvider> {

  @override
  void initState() {
    super.initState();
    context.read<EntryBloc>().add(CheckLogin());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.surface,
            statusBarIconBrightness: Brightness.dark
        ));
    return BlocConsumer<EntryBloc, EntryState>(
        listener: (context, state) {
          if(state.status == LoginStatus.hasLogged) {
            Navigator.pushReplacementNamed(context, 'listing');
          }
          else {
            Navigator.pushReplacementNamed(context, 'login');
          }
          print('@@@@@@@@@@@@@@@@@@ Login state: ${state.status}');
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: Center(
                  child: Image.asset(
                      'assets/images/mobile_listing_logo.png',
                      fit: BoxFit.contain,
                      height: 72,
                      width: 72
                  )
              )
          );
        });
  }

}