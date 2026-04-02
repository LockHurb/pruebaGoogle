# Documentación de eventos de analítica en botones

Este documento describe los eventos de analítica registrados en la aplicación para cada interacción de botón, utilizando el servicio `AnalyticsService.logEvent`.

## Página principal

- **Incrementar contador**
  - Evento: `click_increment_counter`
  - Parámetros: `{ counter_value: <nuevo valor>, page: 'principal' }`
  - Descripción: Se registra cada vez que el usuario incrementa el contador.

- **Ir a 2da Página imagen**
  - Evento: `click_nav_button`
  - Parámetros: `{ destination: 'Segunda página' }`
  - Descripción: Se registra al navegar a la segunda página.

- **Ir a 3ra Página botones**
  - Evento: `click_nav_button`
  - Parámetros: `{ destination: '3ra Página botones' }`
  - Descripción: Se registra al navegar a la tercera página.

- **Mostrar diálogo de bienvenida**
  - Evento: `click_welcome_dialog`
  - Parámetros: `{ page: 'principal' }`
  - Descripción: Se registra al mostrar el diálogo de bienvenida.

## Segunda página

- **Agrandar imagen**
  - Evento: `click_enlarge_image_button`
  - Parámetros: `{ page: 'segunda' }`
  - Descripción: Se registra al pulsar el botón para agrandar la imagen.

- **Mostrar información extra**
  - Evento: `click_info_dialog_button`
  - Parámetros: `{ page: 'segunda' }`
  - Descripción: Se registra al pulsar el botón para mostrar información adicional.

- **Volver a Página principal**
  - Evento: `click_nav_button`
  - Parámetros: `{ destination: 'Página principal' }`
  - Descripción: Se registra al volver a la página principal.

## Tercera página

- **Volver a Página principal**
  - Evento: `click_nav_button`
  - Parámetros: `{ destination: 'Página principal' }`
  - Descripción: Se registra al volver a la página principal.

- **Botón inútil**
  - Evento: `click_useless_button`
  - Parámetros: _Ninguno_
  - Descripción: Se registra al pulsar el botón que no realiza ninguna acción.

- **Cambiar color de fondo**
  - Evento: `click_change_background_color`
  - Parámetros: `{ page: 'tercera' }`
  - Descripción: Se registra al cambiar el color de fondo de la página.

- **Mostrar SnackBar**
  - Evento: `click_show_snackbar`
  - Parámetros: `{ page: 'tercera' }`
  - Descripción: Se registra al mostrar el SnackBar exclusivo de la tercera página.

---

Cada evento se registra usando el método `AnalyticsService.logEvent`, permitiendo un seguimiento detallado de la interacción del usuario con la interfaz.