import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_blocs/core/constants/ui_message_type.dart';
import 'package:test_blocs/core/utils/ui_message_extension.dart';
import 'package:test_blocs/presentation/blocs/auth/auth_bloc.dart';
import 'package:test_blocs/presentation/blocs/math/math_bloc.dart';
import 'package:test_blocs/presentation/widgets/language_selector_bottom_sheet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MathBloc _mathBloc;
  late AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    _mathBloc = context.read<MathBloc>();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _logout() {
    _authBloc.add(AuthLoggedOut());
    context.showUiMessage(
      'auth.logout_success'.tr(),
      type: UiMessageType.success,
    );
  }

  void _incrementCounter() {
    _mathBloc.add(IncrementEvent());
  }

  void _decrementCounter() {
    _mathBloc.add(DecrementEvent());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: BlocBuilder<MathBloc, MathState>(
        bloc: _mathBloc,
        builder: (context, state) {
          int counterValue = state.result ?? 0;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('You have pushed the button this many times:'),
                Text(
                  '$counterValue',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 50,
                  children: [
                    ElevatedButton(
                      onPressed: _decrementCounter,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(4),
                        backgroundColor: Colors.red,
                      ),
                      child: Icon(Icons.remove, color: Colors.white, size: 24),
                    ),
                    ElevatedButton(
                      onPressed: _incrementCounter,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(4),
                        backgroundColor: Colors.green,
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'auth.logout'.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => showLanguageBottomSheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'locale.select_button'.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
