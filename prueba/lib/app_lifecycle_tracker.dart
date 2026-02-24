import 'package:flutter/material.dart';
import 'analytics_service.dart';

class AppLifecycleTracker extends StatefulWidget {
  final Widget child;
  const AppLifecycleTracker({super.key, required this.child});

  @override
  State<AppLifecycleTracker> createState() => _AppLifecycleTrackerState();
}

class _AppLifecycleTrackerState extends State<AppLifecycleTracker>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AnalyticsService().trackEvent(
        eventType: "app_background",
        screenName: "app",
      );
    }

    if (state == AppLifecycleState.resumed) {
      AnalyticsService().trackEvent(
        eventType: "app_foreground",
        screenName: "app",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
