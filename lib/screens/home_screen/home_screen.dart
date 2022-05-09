import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_provider/services/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderListener<AsyncValue<void>>(
        provider: streamProvider,
        onChange: (context, oldValue, AsyncValue? newValue) {
          newValue!.when(
              data: (data) {
                if (data is AsyncData) {
                  print('ok');
                } else if (data is AsyncError) {
                  print(data.error.toString());
                  print(data.stackTrace.toString());
                }
              },
              error: (error, stackTrace) {
                print(error.toString());
                print(stackTrace.toString());
              },
              loading: () {});
        },
        child: Container(),
      ),
    );
  }
}
