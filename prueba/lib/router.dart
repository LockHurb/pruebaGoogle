import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'analytics_service.dart';
import 'main.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

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
    AnalyticsService.logScreen(screenName: screenName);
  });
}

class NavShell extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  const NavShell({Key? key, required this.child, required this.currentIndex}) : super(key: key);

  @override
  State<NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<NavShell> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/second');
        break;
      case 2:
        context.go('/third');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Imagen'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_button), label: 'Botones'),
        ],
      ),
    );
  }
}

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        int idx = 0;
        if (state.fullPath == '/second') idx = 1;
        if (state.fullPath == '/third') idx = 2;
        return NavShell(currentIndex: idx, child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => Title(
            title: 'Página principal',
            color: Colors.blue,
            child: const MyHomePage(title: 'Página Principal'),
          ),
        ),
        GoRoute(
          path: '/second',
          name: 'second_page',
          builder: (context, state) => Title(
            title: 'Segunda página',
            color: Colors.blue,
            child: const SecondPage(),
          ),
        ),
        GoRoute(
          path: '/third',
          name: 'third_page',
          builder: (context, state) => Title(
            title: '3ra Página botones',
            color: Colors.blue,
            child: const ThirdPage(),
          ),
        ),
      ],
    ),
  ],
);
