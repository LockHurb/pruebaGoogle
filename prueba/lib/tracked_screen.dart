import 'package:flutter/material.dart';
import 'analytics_service.dart';
import 'main.dart';

mixin TrackedScreen<T extends StatefulWidget> on State<T>
    implements RouteAware {
  String get screenName;

  DateTime? _enteredAt;
  String? _screenInstanceId;
  bool _goalCompletionTracked = false;

  void setLastTrackedAction(String action) {
    AnalyticsService().setActiveScreenLastAction(action);
  }

  void markScreenGoalCompleted(String goalName) {
    if (_enteredAt == null || _screenInstanceId == null || _goalCompletionTracked) {
      return;
    }

    _goalCompletionTracked = true;
    final now = DateTime.now();
    final elapsedMs = now.difference(_enteredAt!).inMilliseconds;
    final analytics = AnalyticsService();

    analytics.markActiveScreenGoalCompleted();
    analytics.trackEvent(
      eventType: 'screen_goal_completed',
      screenName: screenName,
      metadata: {
        'screen_instance_id': _screenInstanceId,
        'goal_name': goalName,
        'time_to_complete_ms': elapsedMs,
      },
    );
  }

  void _onScreenEnter({required String transitionType}) {
    final analytics = AnalyticsService();
    final previousScreen = transitionType == 'pop_return'
        ? analytics.consumeLastExitedScreenName()
        : analytics.activeScreenName;

    final now = DateTime.now();
    _enteredAt = now;
    _screenInstanceId = analytics.generateScreenInstanceId();
    _goalCompletionTracked = false;

    analytics.setActiveScreen(
      screenName: screenName,
      screenInstanceId: _screenInstanceId!,
      enteredAt: now,
      lastAction: 'screen_enter',
    );

    analytics.trackEvent(
      eventType: 'screen_enter',
      screenName: screenName,
      metadata: {
        'screen_instance_id': _screenInstanceId,
        'previous_screen': previousScreen ?? 'none',
      },
    );

    analytics.trackEvent(
      eventType: 'screen_transition',
      screenName: screenName,
      metadata: {
        'from_screen': previousScreen ?? 'none',
        'to_screen': screenName,
        'step_index': analytics.nextNavigationStep(),
        'transition_type': transitionType,
        'screen_instance_id': _screenInstanceId,
      },
    );
  }

  void _onScreenExit({required String exitReason}) {
    if (_enteredAt == null || _screenInstanceId == null) {
      return;
    }

    final now = DateTime.now();
    final elapsedMs = now.difference(_enteredAt!).inMilliseconds;
    final analytics = AnalyticsService();

    analytics.trackEvent(
      eventType: 'screen_exit',
      screenName: screenName,
      metadata: {
        'screen_instance_id': _screenInstanceId,
        'duration_ms': elapsedMs,
        'exit_reason': exitReason,
      },
    );

    if (exitReason == 'pop_back') {
      analytics.setLastExitedScreenName(screenName);
      analytics.clearActiveScreenIfMatches(
        screenName: screenName,
        screenInstanceId: _screenInstanceId!,
      );
    }
  }

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
    _onScreenEnter(transitionType: 'push');
  }

  @override
  void didPop() {
    _onScreenExit(exitReason: 'pop_back');
  }

  @override
  void didPopNext() {
    _onScreenEnter(transitionType: 'pop_return');
  }

  @override
  void didPushNext() {
    _onScreenExit(exitReason: 'push_next');
  }
}
