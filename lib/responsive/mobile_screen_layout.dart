import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/repositories/auth_repository.dart';

class MobileScreenLayout extends ConsumerWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ref.read(authRepositoryProvider).signout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text('This is Mobile')),
    );
  }
}
