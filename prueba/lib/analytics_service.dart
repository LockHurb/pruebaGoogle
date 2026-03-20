import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Servicio centralizado para enviar métricas generales y anónimas a Firebase.
class AnalyticsService {
  // Constructor privado para evitar instanciación. Se usan métodos estáticos.
  AnalyticsService._();

  /// Instancia principal de Firebase Analytics
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // -----------------------------
  // EVENTOS GENERALES
  // -----------------------------
  /// Registra una acción específica del usuario (ej. 'click_comprar', 'abrir_menu').
  static Future<void> logEvent({
    required final String name,
    final Map<String, Object>? params,
  }) async {
<<<<<<< HEAD
    await _analytics.logEvent(
      name: eventType,
      parameters: {
        'screen_name': screenName,
        'app_session_id': sessionId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        ...?metadata,
      },
    );
  }
  // }) {
  //   final event = {
  //     'event_id': 1000,
  //     'app_session_id': sessionId,
  //     'event_type': eventType,
  //     'screen_name': screenName,
  //     'timestamp': DateTime.now().toUtc().toIso8601String(),
  //     'metadata': metadata ?? {},
  //   };
=======
    try {
      await analytics.logEvent(
        name: _cleanName(name),
        parameters: params,
      );
    } catch (e) {
      if (kDebugMode) print('Error Analytics logEvent: $e');
    }
  }
>>>>>>> b735c8b2207e5eee79e2df12cf804eb23a1804d1

  // -----------------------------
  // SCREEN VIEWS
  // -----------------------------
  /// Registra la pantalla actual para medir tiempos de retención y rutas 
  /// de navegación automáticamente en Firebase y Looker Studio.
  static Future<void> logScreen({
    required final String screenName,
  }) async {
    try {
      await analytics.logScreenView(
        screenName: _cleanName(screenName),
        screenClass: _cleanName(screenName), // Ayuda a Looker Studio a clasificar mejor
      );
    } catch (e) {
      if (kDebugMode) print('Error Analytics logScreen: $e');
    }
  }

  // -----------------------------
  // HELPER INTERNO
  // -----------------------------
  /// Limpia el nombre del evento o pantalla para cumplir con los estándares de Firebase
  /// (sin espacios, en minúsculas y sin barras diagonales al inicio).
  static String _cleanName(final String name) {
    var tmp = name.trim().toLowerCase();
    
    // Quita el '/' si usas rutas nombradas en Flutter (ej. '/home' pasa a 'home')
    if (tmp.startsWith('/')) tmp = tmp.replaceFirst('/', '');
    
    // Cambia espacios por guiones bajos (ej. 'mi pantalla' pasa a 'mi_pantalla')
    tmp = tmp.replaceAll(' ', '_');
    
    return tmp;
  }
}