import 'dart:math';
// import 'package:uuid/uuid.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final String sessionId = Random().nextInt(1000).toString();

  Future<void> trackEvent({
    required String eventType,
    required String screenName,
    Map<String, dynamic>? metadata,
  }) async {
    // final event = {
    //   'event_id': Random().nextInt(1000),
    //   'session_id': sessionId,
    //   'event_type': eventType,
    //   'screen_name': screenName,
    //   'timestamp': DateTime.now().toUtc().toIso8601String(),
    //   'metadata': metadata ?? {},
    // };

    // // Prueba
    // print(event);

    await _analytics.logEvent(
      name: eventType,
      parameters: {
        'screen_name': screenName,
        'session_id': sessionId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        ...?metadata,
      },
    );
  }
}
