import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          ),
        ],
      ),
    );
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
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    Theme.of(context).colorScheme.onSecondary,
                  ],
                ),
              ),
              child: _selectedBottomTabIndex.canPullToRefresh
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Refreshed'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: _selectedBottomTabIndex.widgetBuilder(),
                      ),
                    )
                  : _selectedBottomTabIndex.widgetBuilder(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        selectedBottomTabIndex: _selectedBottomTabIndex,
        onSelectedBottomTab: (index) {
          setState(() {
            _selectedBottomTabIndex = index;
          });
        },
      ),
    );
  }
}
