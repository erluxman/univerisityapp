import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:university_app/screens/home/home_screen.dart';

import 'blocs/auth/auth_state_provider.dart';
import 'resources/res.dart';
import 'resources/theme.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    required this.selectedBottomTabIndex,
    required this.onSelectedBottomTab,
    Key? key,
  }) : super(key: key);

  final BottomNavItem selectedBottomTabIndex;
  final Function(BottomNavItem) onSelectedBottomTab;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navbarItems.indexOf(selectedBottomTabIndex);
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        onSelectedBottomTab(navbarItems[value]);
      },
      items: navbarItems.map((e) {
        final index = navbarItems.indexOf(e);
        return getBottomChipItem(
            selectedIndex: navbarItems.indexOf(selectedBottomTabIndex),
            index: index,
            context: context,
            label: e.title,
            notifications: index,
            path: e.icon);
      }).toList(),
    );
  }
}

BottomNavigationBarItem getBottomChipItem({
  required int selectedIndex,
  required int index,
  required BuildContext context,
  required String label,
  required String path,
  required int notifications,
}) {
  final iconContainer = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: selectedIndex == index ? Colors.white : Colors.transparent,
    ),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selectedIndex != index
              ? Colors.transparent
              : Theme.of(context).colorScheme.primary.withOpacity(0.80)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Icon(Icons.home),
    ),
  );
  return BottomNavigationBarItem(
    icon: Stack(
      alignment: Alignment.topRight,
      children: [
        iconContainer,
        if (notifications > 0 && index % 2 == 0)
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(500),
            ),
            child: Center(
              child: Text(
                "$notifications",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    ),
    label: label,
  );
}

List<BottomNavItem> get navbarItems => [
      BottomNavItem(
          title: "For You",
          icon: R.svgs.forYou,
          path: "/",
          widgetBuilder: () => const DashBoardScreen()),
      BottomNavItem(
          title: "Insights",
          icon: R.svgs.insights,
          path: "/insights",
          widgetBuilder: () => const DashBoardScreen()),
      BottomNavItem(
          title: "Home",
          icon: R.svgs.home,
          path: "/home",
          widgetBuilder: () => const DashBoardScreen()),
      BottomNavItem(
          title: "Activity",
          icon: R.svgs.activities,
          path: "/activity",
          widgetBuilder: () => const DashBoardScreen()),
      BottomNavItem(
          title: "Profile",
          icon: R.svgs.person,
          path: "/profile",
          canPullToRefresh: false,
          widgetBuilder: () => const DashBoardScreen()),
    ];

class BottomNavItem {
  final String title;
  final String icon;
  final String path;
  final bool canPullToRefresh;

  Widget Function() widgetBuilder;

  BottomNavItem(
      {required this.title,
      required this.icon,
      required this.path,
      required this.widgetBuilder,
      this.canPullToRefresh = true});

  @override
  String toString() =>
      'BottomNavItem(title: $title,canPullToRefresh: $canPullToRefresh, icon: $icon, path: $path, widgetBuilder: $widgetBuilder)';

  @override
  bool operator ==(covariant BottomNavItem other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.canPullToRefresh == canPullToRefresh &&
        other.icon == icon &&
        other.path == path;
  }

  @override
  int get hashCode => title.hashCode ^ icon.hashCode ^ path.hashCode;
}

Widget buildAppBar(
  BuildContext context,
  AuthBloc authBloc,
  ThemeStateProvider provider,
  BottomNavItem selectedBottomNavItem,
  WidgetRef ref,
) {
  final AuthBloc authBloc = ref.watch(authProvider.notifier);
  return Container(
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white,
    height: MediaQuery.of(context).padding.top + AppBar().preferredSize.height+20,
    child: SafeArea(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (selectedBottomNavItem.title.toLowerCase() ==
                    "Home".toLowerCase())
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
          Center(
            child: Text(
              selectedBottomNavItem.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          const Spacer(flex: 1),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authBloc.logout();
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.dark_mode),
              onPressed: () async {
                provider.toggleDarkMode();
              },
            ),
          ),
        ],
      ),
    ),
  );
}
