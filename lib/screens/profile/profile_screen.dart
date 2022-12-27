import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../blocs/auth/auth_state.dart';
import 'package:university_app/utils/utils.dart';
import '../../blocs/auth/auth_state_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isInEditMode = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthState authState = ref.watch(authProvider);
    final AuthBloc authBloc = ref.read(authProvider.notifier);
    final user = authState.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            16.verticalSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(user?.photoUrl ??
                      "https://erluxman.com/static/profile_pic-b899d378689819c43d090532018a5af5.png"),
                ),
                16.verticalSpace(),
                TextFormField(
                  enabled: isInEditMode,
                  expands: false,
                  textAlign: TextAlign.center,
                  initialValue: user?.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) {
                    authBloc.updateName(value);
                  },
                ),
                Text(user?.name ?? "-"),
                16.verticalSpace(),
                Text(user?.email ?? "-")
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          setState(() {
            isInEditMode = !isInEditMode;
          });
        },
        child: Icon(isInEditMode ? Icons.save : Icons.edit),
      ),
    );
  }
}
