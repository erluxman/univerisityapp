import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:university_app/screens/home/home_screen.dart';
import 'package:university_app/screens/profile/profile_screen.dart';


final Provider<BeamerDelegate> beamerDelegateProvider =
    Provider<BeamerDelegate>(
  (ref) => BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const DashBoardScreen(),
        '/profile': (context, state, data) => const ProfileScreen(),
        // '/pools/:poolsId': (context, state, data) =>
        //     PoolDetailsPage(poolId: state.pathParameters['poolsId']!),
        // '/manage_account/:accountType': (context, state, data) =>
        //     ManageAccountScreen(
        //         accountType: state.pathParameters['accountType']!),
        // '/manage_account': (context, state, data) => ManageAccountScreen(),
      },
    ),
  ),
);
