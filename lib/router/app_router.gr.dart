// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i5;

import '../features/auth/presentation/login_page.dart' as _i3;
import '../features/auth/presentation/signup_page.dart' as _i4;
import 'app_router.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    TempHomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.TempHomePage());
    },
    LoadingRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoadingPage());
    },
    ErrorRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.ErrorPage(key: args.key, e: args.e, trace: args.trace));
    },
    AuthRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    LoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginPage());
    },
    SignupRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.SignupPage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(TempHomeRoute.name, path: '/'),
        _i2.RouteConfig(LoadingRoute.name, path: '/loading-page'),
        _i2.RouteConfig(ErrorRoute.name, path: '/error-page'),
        _i2.RouteConfig(AuthRouter.name, path: '/auth', children: [
          _i2.RouteConfig(LoginRoute.name, path: '', parent: AuthRouter.name),
          _i2.RouteConfig(SignupRoute.name,
              path: 'signup', parent: AuthRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.TempHomePage]
class TempHomeRoute extends _i2.PageRouteInfo<void> {
  const TempHomeRoute() : super(TempHomeRoute.name, path: '/');

  static const String name = 'TempHomeRoute';
}

/// generated route for
/// [_i1.LoadingPage]
class LoadingRoute extends _i2.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: '/loading-page');

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i1.ErrorPage]
class ErrorRoute extends _i2.PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({_i5.Key? key, required Object e, required StackTrace? trace})
      : super(ErrorRoute.name,
            path: '/error-page',
            args: ErrorRouteArgs(key: key, e: e, trace: trace));

  static const String name = 'ErrorRoute';
}

class ErrorRouteArgs {
  const ErrorRouteArgs({this.key, required this.e, required this.trace});

  final _i5.Key? key;

  final Object e;

  final StackTrace? trace;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, e: $e, trace: $trace}';
  }
}

/// generated route for
/// [_i2.EmptyRouterPage]
class AuthRouter extends _i2.PageRouteInfo<void> {
  const AuthRouter({List<_i2.PageRouteInfo>? children})
      : super(AuthRouter.name, path: '/auth', initialChildren: children);

  static const String name = 'AuthRouter';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.SignupPage]
class SignupRoute extends _i2.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: 'signup');

  static const String name = 'SignupRoute';
}
