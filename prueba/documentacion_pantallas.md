# Guía rápida para registrar vistas de pantalla (`logScreenView`)

> [!NOTE]
> Esta guía explica cómo y cuándo usar `AnalyticsService.logScreen` para registrar vistas de pantalla en Firebase Analytics.

---

## Propósito

Registrar cada vez que el usuario navega a una pantalla relevante, permitiendo medir retención, rutas de navegación y analizar el flujo de la app.

---

## Reglas para el uso de logScreen

> [!IMPORTANT]
> Llama a `AnalyticsService.logScreen(screenName: ...)` cada vez que el usuario navegue a una pantalla principal.

- El nombre de pantalla debe estar en inglés, minúsculas y en snake_case.
- Usa el nombre lógico de la pantalla, no el nombre del widget ni la ruta.
- No incluyas barras diagonales ni espacios.
- Si alguna de estas reglas contradice lo que ya se lleva en la aplicación, toma las consideraciones que debas.

---

## Ejemplo de uso

```dart
AnalyticsService.logScreen(screenName: "second_page");
```

---

## Buenas prácticas

> [!TIP]
> Automatiza el registro de pantallas integrando la llamada en el listener de tu router (como en `setupAnalyticsTracking`).

> [!CAUTION]
> No registres pantallas para diálogos, popups o elementos secundarios; solo para pantallas principales de navegación.
