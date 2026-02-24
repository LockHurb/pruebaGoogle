import 'package:flutter/material.dart';
import 'analytics_service.dart';

/// Wrapper (envoltorio) a nivel raíz para monitorear el ciclo de vida de la aplicación.
///
/// Utiliza [WidgetsBindingObserver] para interceptar las señales del sistema operativo
/// y detectar cuándo la app pasa a primer o segundo plano.
class AppLifecycleTracker extends StatefulWidget {
  /// El widget hijo que será envuelto, usualmente la raíz de navegación (ej. MaterialApp).
  final Widget child;
  const AppLifecycleTracker({super.key, required this.child});

  @override
  State<AppLifecycleTracker> createState() => _AppLifecycleTrackerState();
}

/// Estado interno que gestiona la suscripción a los eventos del motor de Flutter.
class _AppLifecycleTrackerState extends State<AppLifecycleTracker>
    with WidgetsBindingObserver {
  bool _isBackground = false;

  /// Registra este widget como observador del ciclo de vida al insertarse en el árbol.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  /// Elimina la suscripción al destruirse el widget para evitar fugas de memoria (memory leaks).
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Intercepta y procesa los cambios de estado dictados por el sistema operativo (Android/iOS).
  ///
  /// Mapea los estados nativos a eventos analíticos comprensibles:
  /// - [AppLifecycleState.paused]: El usuario minimizó la app o bloqueó la pantalla.
  /// - [AppLifecycleState.resumed]: El usuario volvió a la app.
  ///
  /// Ignora estados transitorios como `inactive` o `detached`.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isCurrentlyBackground =
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden;

    if (isCurrentlyBackground && !_isBackground) {
      _isBackground = true;
      AnalyticsService().trackEvent(
        eventType: "app_background",
        screenName: "app",
      );
    } else if (state == AppLifecycleState.resumed && _isBackground) {
      _isBackground = false;
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
