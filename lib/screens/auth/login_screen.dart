import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:university_app/utils/utils.dart';

import '../../blocs/auth/auth_state.dart';
import '../../blocs/auth/auth_state_provider.dart';
import '../../resources/theme.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const AuthScreenContent(),
    );
  }
}

class AuthScreenContent extends ConsumerWidget {
  const AuthScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthBloc authBloc = ref.watch(authProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Image.network(
              "https://www.mwu.edu.np/wp-content/themes/muniversity/images/mu%20logo.png",
              height: 100,
            ),
            32.verticalSpace(),
            Center(
              child: Lottie.network(
                "https://assets10.lottiefiles.com/packages/lf20_1a8dx7zj.json",
                width: 200,
              ),
            ),
            32.verticalSpace(),
            Text(
              'Mid-West\nUniversity',
              style: GoogleFonts.lato().copyWith(fontSize: 30),
            ),
            32.verticalSpace(),
            ElevatedButton.icon(
              onPressed: () {
                authBloc.loginWithGoogle();
              },
              icon: const Icon(FontAwesomeIcons.google),
              label: const Text("Continue with Google"),
            )
          ],
        ),
      ),
    );
  }
}

