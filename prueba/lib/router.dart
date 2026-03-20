import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'analytics_service.dart';
import 'main.dart'; // Permite acceder a las páginas (MyHomePage, SecondPage, ThirdPage)

String? _lastLocation;

void setupAnalyticsTracking(GoRouter targetRouter) {
  targetRouter.routerDelegate.addListener(() {
    final uri = targetRouter.routeInformationProvider.value.uri.toString();

    if (_lastLocation == uri) return;
    _lastLocation = uri;

    final matches = targetRouter.routerDelegate.currentConfiguration;
    if (matches.isEmpty) return;

    final lastMatch = matches.last;
    final screenName = lastMatch.route.name;

    if (screenName == null || screenName.isEmpty) return;

    AnalyticsService.logScreen(screenName: screenName.toLowerCase());
  });
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'Página principal',
      builder: (context, state) => Title(
        title: 'Página principal',
        color: Colors.blue,
        child: const MyHomePage(title: 'Página Principal'),
      ),
    ),
    GoRoute(
      path: '/second',
      name: 'Segunda página',
      builder: (context, state) => Title(
        title: 'Segunda página',
        color: Colors.blue,
        child: const SecondPage(),
      ),
    ),
    GoRoute(
      path: '/third',
      name: '3ra Página botones',
      builder: (context, state) => Title(
        title: '3ra Página botones',
        color: Colors.blue,
        child: const ThirdPage(),
      ),
    ),
  ],
);
