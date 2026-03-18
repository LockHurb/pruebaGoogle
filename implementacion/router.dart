import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keepers_app/core/firebase/analytics_service.dart';
import 'package:keepers_app/core/utils/compile_mode.dart';
import 'package:keepers_app/core/widgets/ek_scaffold.dart';
import 'package:keepers_app/features/account/presentation/routes/account_routes.dart';
import 'package:keepers_app/features/alerts/presentation/routes/alerts_routes.dart';
import 'package:keepers_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:keepers_app/features/home/presentation/routes/home_routes.dart';
import 'package:keepers_app/features/no_internet/presentation/routes/no_internet_routes.dart';
import 'package:keepers_app/features/notifications/presentation/routes/notifications_routes.dart';
import 'package:keepers_app/features/on_boardings/presentation/routes/on_boardings_routes.dart';
import 'package:keepers_app/features/recursos_interes/presentation/routes/recursos_interes_route.dart';
import 'package:keepers_app/features/respira_y_conectate/presentation/routes/respira_routes.dart';
import 'package:keepers_app/features/splash/presentation/routes/splash_route.dart';
import 'package:keepers_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:keepers_app/features/temas_interes/presentation/routes/temas_interes_routes.dart';
import 'package:keepers_app/features/tests/presentation/routes/test_routes.dart';
import 'package:keepers_app/features/tests_terceros/presentation/routes/test_terceros_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKeyMain = GlobalKey<NavigatorState>();
final shellNavigatorKeyAuth = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: SplashScreen.route,
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKeyMain,
      builder: (final context, final state, final child) =>
          EKScaffold(child: child),
      routes: [
        ...homeRoutes,
        ...alertsRoutes,
        ...testRoutes,
        ...testTercerosRoutes,
        ...accountRoutes,
        ...temasInteresRoutes,
        ...recursosInteresRoutes,
        ...respiraConectateRoutes,
        ...notificationRoutes,
      ],
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKeyAuth,
      builder: (final context, final state, final child) =>
          Scaffold(body: SafeArea(child: child)),
      routes: [
        splashRoute,
        ...authRoutes,
        ...noInternetRoutes,
        ...onBoardingRoutes,
      ],
    ),
  ],
);

String? _lastLocation;

void setupAnalyticsTracking() {
  router.routerDelegate.addListener(() {
    final uri = router.routeInformationProvider.value.uri.toString();

    if (_lastLocation == uri) return;
    _lastLocation = uri;

    final matches = router.routerDelegate.currentConfiguration;

    if (matches.isEmpty) return;

    final lastMatch = matches.last;

    final screenName = lastMatch.route.name;

    if (screenName == null || screenName.isEmpty) return;

    if (isRelease()) {
      AnalyticsService.logScreen(
        screenName: screenName.toLowerCase(),
      );
    }
  });
}
