import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/auth/presentation/signup_page.dart';
import 'firebase_options.dart';
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
      child: const MyApp(),
      observers: [ProviderLogObserver(AppLogger())],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Flutter Fire',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.black,
          background: Colors.black,
        ),
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: const SignupPage(),
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
