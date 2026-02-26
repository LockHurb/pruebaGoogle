import 'package:uuid/uuid.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// Servicio centralizado para enviar métricas de uso a Firebase.
///
/// Usa el patrón Singleton: solo existe una instancia de esta clase en toda la app.
/// Esto facilita llamar a [trackEvent] desde cualquier lugar, pero hace que la clase
/// sea más difícil de someter a pruebas unitarias (testing) por su fuerte acoplamiento.
class AnalyticsService {
  /// Instancia única guardada en memoria.
  static final AnalyticsService _instance = AnalyticsService._internal();

  /// Devuelve siempre la misma instancia.
  factory AnalyticsService() => _instance;

  /// Constructor privado para evitar que se creen múltiples instancias.
  AnalyticsService._internal();

  /// Cliente directo de Firebase Analytics.
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// ID único generado al iniciar la app.
  ///
  /// **Riesgo de datos:** Esto funciona como el ID del proceso en memoria, NO como
  /// una sesión real de usuario. Si el usuario minimiza la app hoy y la reabre mañana
  /// sin cerrarla por completo, este ID será exactamente el mismo. Esto ensuciará
  /// tus métricas si intentas medir tiempos de sesión o embudos de conversión.
  final String sessionId = const Uuid().v4();

  /// Envía un evento a Firebase uniendo los datos del evento con datos automáticos.
  ///
  /// [eventType] La acción que hizo el usuario (ej. 'click_comprar').
  ///
  /// [screenName] El nombre de la pantalla donde ocurrió el evento.
  ///
  /// [metadata] Información extra opcional sobre el evento (ej. {'precio': 20.5}).
  Future<void> trackEvent({
    required String eventType,
    required String screenName,
    Map<String, dynamic>? metadata,
  }) async {
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
  // }) {
  //   final event = {
  //     'event_id': 1000,
  //     'session_id': sessionId,
  //     'event_type': eventType,
  //     'screen_name': screenName,
  //     'timestamp': DateTime.now().toUtc().toIso8601String(),
  //     'metadata': metadata ?? {},
  //   };

  //   // Prueba
  //   print(event);

  //   return Future.value();
  // }
}
