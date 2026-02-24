import 'package:flutter/material.dart';
import 'analytics_service.dart';
import 'main.dart';

mixin TrackedScreen<T extends StatefulWidget> on State<T>
    implements RouteAware {
  String get screenName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    AnalyticsService().trackEvent(
      eventType: "screen_enter",
      screenName: screenName,
    );
  }

  @override
  void didPop() {
    AnalyticsService().trackEvent(
      eventType: "screen_exit",
      screenName: screenName,
    );
  }

  @override
  void didPopNext() {}

  @override
  void didPushNext() {}
}
