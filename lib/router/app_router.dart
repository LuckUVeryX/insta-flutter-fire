import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/signup_page.dart';
import '../responsive/responsive.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: TempHomePage),
    AutoRoute(page: LoadingPage),
    AutoRoute(page: ErrorPage),
    AutoRoute(
      name: 'AuthRouter',
      path: '/auth',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: LoginPage),
        AutoRoute(path: 'signup', page: SignupPage),
      ],
    ),
  ],
)
class $AppRouter {}

class TempHomePage extends StatelessWidget {
  const TempHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScreenLayout: MobileScreenLayout(),
      webScreenLayout: WebScreenLayout(),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class ErrorPage extends StatefulWidget {
  const ErrorPage({
    Key? key,
    required this.e,
    required this.trace,
  }) : super(key: key);

  final Object e;
  final StackTrace? trace;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
    if (widget.trace != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.trace.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(widget.e.toString())));
  }
}
