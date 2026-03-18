import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsService {
  AnalyticsService._();

  /// Instancia principal de Firebase Analytics
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // -----------------------------
  // 🔵 EVENTOS
  // -----------------------------
  static Future<void> logEvent({
    required final String name,
    final Map<String, Object>? params,
  }) async {
    try {
      await analytics.logEvent(
        name: _cleanName(name),
        parameters: params,
      );
    } catch (e) {
      if (kDebugMode) print('Error logEvent: $e');
    }
  }

  // -----------------------------
  // 🔴 SCREEN VIEW
  // -----------------------------
  static Future<void> logScreen({
    required final String screenName,
  }) async {
    // final genero = di<AuthBloc>().state.authProp.userPhoto?.genero;
    // if (genero != null && genero.isNotEmpty) {
    // }
    try {
      await analytics.logScreenView(
        screenName: _cleanName(screenName),
        screenClass: _cleanName(screenName),
      );
    } catch (e) {
      if (kDebugMode) print('Error logScreen: $e');
    }
  }

  // -----------------------------
  // 🟢 USER ID
  // -----------------------------
  static Future<void> setUserId({
    required final String userId,
  }) async {
    try {
      await analytics.setUserId(id: userId);
    } catch (e) {
      if (kDebugMode) print('Error userId: $e');
    }
  }

  // -----------------------------
  // 🟢 USER PROPERTIES
  // -----------------------------
  static Future<void> setUserProperty({
    required final String key,
    required final String value,
  }) async {
    try {
      await analytics.setUserProperty(
        name: _cleanName(key),
        value: value,
      );
    } catch (e) {
      if (kDebugMode) print('Error userProperty: $e');
    }
  }

  // -----------------------------
  // 🔧 Helper interno
  // -----------------------------
  static String _cleanName(final String name) {
    var tmp = name.trim().toLowerCase();

    if (tmp.startsWith('/')) tmp = tmp.replaceFirst('/', '');

    tmp = tmp.replaceAll(' ', '_');

    return tmp;
  }

  static const String _kLastUserHash = 'last_analytics_user_hash';

  static Future<void> syncUserAnalytics({
    required final String userId,
    required final String age,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Creamos un string único que represente el estado actual del usuario
      final currentHash = '$userId-$age';
      final lastHash = prefs.getString(_kLastUserHash);

      // Si el hash es igual, no hacemos nada (ahorramos red y batería)
      if (currentHash == lastHash) return;

      // 1. Establecer el ID de usuario (el alias como pgudino)
      await setUserId(userId: userId);

      // 2. Establecer propiedades de usuario
      await setUserProperty(key: 'user_age', value: age);

      // 3. Guardar en caché que ya enviamos esta info
      await prefs.setString(_kLastUserHash, currentHash);

      if (kDebugMode) print('Analytics: Información de usuario sincronizada');
    } catch (e) {
      if (kDebugMode) print('Error syncUserAnalytics: $e');
    }
  }
}
