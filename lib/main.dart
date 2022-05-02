import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/auth/repositories/auth_repository.dart';
import 'firebase_options.dart';
import 'router/app_router.gr.dart';
import 'utils/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const bool useFirebaseEmulator = true;
  if (useFirebaseEmulator && kDebugMode) {
    await _configureFirebaseEmulator();
  }

  runApp(
    ProviderScope(
      child: MyApp(),
      observers: [ProviderLogObserver(AppLogger())],
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authLoginStatus = ref.watch(authLoginStatusProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Flutter Fire',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.black,
          background: Colors.black,
        ),
      ),
      routeInformationParser: _appRouter.defaultRouteParser(
        includePrefixMatches: true,
      ),
      routerDelegate: AutoRouterDelegate.declarative(
        _appRouter,
        routes: authLoginStatus.when(
          data: ((isLoggedIn) => (_) => [
                if (isLoggedIn) const TempHomeRoute() else const AuthRouter(),
              ]),
          error: (e, trace) => (_) => [ErrorRoute(e: e, trace: trace)],
          loading: () => (_) => [const LoadingRoute()],
        ),
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
    );
  }
}

Future<void> _configureFirebaseEmulator() async {
  const host = String.fromEnvironment('IPADDR');
  FirebaseFirestore.instance.settings = const Settings(
    host: '$host:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  await FirebaseStorage.instance.useStorageEmulator(host, 9199);
}
