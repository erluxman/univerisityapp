import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../blocs/auth/auth_state.dart';
import '../../blocs/auth/auth_state_provider.dart';
import '../../menus.dart';
import '../../resources/theme.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  BottomNavItem _selectedBottomTabIndex = navbarItems.first;

  @override
  Widget build(BuildContext context) {
    final ThemeStateProvider provider = ref.watch(themeProvider.notifier);
    final AuthBloc authBloc = ref.watch(authProvider.notifier);
    final AuthState authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: Column(
        children: [
          buildAppBar(
            context,
            authBloc,
            provider,
            _selectedBottomTabIndex,
            ref,
            authState,
          ),
        ],
      ),
    );
  }
}
