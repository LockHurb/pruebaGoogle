# Guía estandarizada de eventos de analítica en Flutter

> [!NOTE]
> Este documento define las convenciones oficiales para nombrar, estructurar y registrar eventos personalizados en la aplicación mediante `AnalyticsService.logEvent`.

Este documento define las convenciones oficiales para nombrar, estructurar y registrar eventos personalizados en la aplicación mediante `AnalyticsService.logEvent`.

> [!TIP]
> Dirigido a cualquier desarrollador que necesite crear, modificar o mantener eventos de analítica en el futuro. Su objetivo es garantizar consistencia, claridad y utilidad analítica.

---

## 1. Propósito

**Objetivo:**
Establecer un estándar único para:
- Nombrado de eventos
- Definición de parámetros
- Organización semántica

**Este estándar evita:**
- Eventos duplicados
- Nombres ambiguos
- Datos sin valor analítico

---

## 2. Principios obligatorios

> [!IMPORTANT]
> Todos los eventos deben cumplir las siguientes reglas para evitar problemas de análisis y duplicidad.

### 2.1 Prefijo obligatorio

> [!IMPORTANT]
> Todos los eventos personalizados deben comenzar con:

```

click_

```

> [!NOTE]
> Esto permite diferenciarlos de los eventos automáticos del sistema de analítica.

---

### 2.2 Formato del nombre

> [!IMPORTANT]
> Los nombres de eventos deben ser:

- En inglés
- En minúsculas
- En formato `snake_case`
- Sin espacios ni camelCase

---

### 2.3 Basados en intención

> [!TIP]
> El nombre del evento debe describir la **acción que ocurre**, no el componente visual.

#### Correcto:
- `click_increment_counter`
- `click_open_welcome_dialog`

#### Incorrecto:
- `click_button`
- `click_blue_button`

---

## 3. Estructura del nombre del evento

> [!IMPORTANT]
> Formato obligatorio:

```

click_<action>*<object>[*<context>]

````

### Ejemplos correctos

- `click_increment_counter`
- `click_open_welcome_dialog`
- `click_navigate_to_second_page`
- `click_change_background_color`

### Ejemplos incorrectos

- `click_button` → demasiado genérico  
- `click_nav_button` → no indica destino  
- `click_image` → no describe acción  
- `click_dialog` → ambiguo  

---

## 4. Estructura de parámetros

> [!TIP]
> Incluye parámetros que permitan análisis posteriores y segmentación.

### Parámetros estándar

| Parámetro | Descripción |
|----------|------------|
| `page`   | Pantalla donde ocurre el evento |
| `target` | Destino o elemento afectado |
| `value`  | Valor relevante (si aplica) |

---

### Ejemplo correcto

```json
{
  "page": "home",
  "target": "second_page",
  "value": 5
}
````

---

### Ejemplo incorrecto

```json
{
  "screen": "pantalla1",
  "dato": "x"
}
```

Problemas:

* Nombres inconsistentes
* Mezcla de idiomas
* Parámetros sin significado analítico

---

## 5. Estandarización de páginas

> [!IMPORTANT]
> Usa nombres consistentes para todas las pantallas:

* `home`
* `second_page`
* `third_page`

### Incorrecto

* `principal`
* `Página 2`
* `pageTwo`

---

## 6. Eventos implementados

### 6.1 Página principal (`home`)

#### Incrementar contador

* Evento: `click_increment_counter`
* Parámetros:

```json
{ "page": "home", "value": <nuevo_valor> }
```

---

#### Navegar a segunda página

* Evento: `click_navigate_to_second_page`
* Parámetros:

```json
{ "page": "home", "target": "second_page" }
```

---

#### Navegar a tercera página

* Evento: `click_navigate_to_third_page`
* Parámetros:

```json
{ "page": "home", "target": "third_page" }
```

---

#### Mostrar diálogo de bienvenida

* Evento: `click_open_welcome_dialog`
* Parámetros:

```json
{ "page": "home" }
```

---

### 6.2 Segunda página (`second_page`)

#### Agrandar imagen

* Evento: `click_enlarge_image`
* Parámetros:

```json
{ "page": "second_page" }
```

---

#### Mostrar información adicional

* Evento: `click_open_info_dialog`
* Parámetros:

```json
{ "page": "second_page" }
```

---

#### Volver a página principal

* Evento: `click_navigate_to_home`
* Parámetros:

```json
{ "page": "second_page", "target": "home" }
```

---

### 6.3 Tercera página (`third_page`)

#### Volver a página principal

* Evento: `click_navigate_to_home`
* Parámetros:

```json
{ "page": "third_page", "target": "home" }
```

---

#### Botón sin acción

* Evento: `click_trigger_noop`
* Parámetros:

```json
{ "page": "third_page" }
```

---

#### Cambiar color de fondo

* Evento: `click_change_background_color`
* Parámetros:

```json
{ "page": "third_page" }
```

---

#### Mostrar SnackBar

* Evento: `click_show_snackbar`
* Parámetros:

```json
{ "page": "third_page" }
```

---

## 7. Reglas para futuros eventos

> [!TIP]
> Antes de crear un nuevo evento, verifica los siguientes puntos:

1. El nombre describe claramente la acción
2. No es ambiguo ni genérico
3. Se entiende sin necesidad de ver el código
4. Incluye parámetros útiles
5. Es consistente con el estándar definido

---

## 8. Errores comunes

### 8.1 Reutilizar eventos

> [!CAUTION]
> No reutilices eventos para diferentes acciones o destinos.
Ejemplo:

```
click_nav_button
```

> [!WARNING]

* No permite identificar el destino
* Reduce la capacidad de análisis

---

### 8.2 Nombrar desde UI

> [!CAUTION]
> No nombres eventos según la apariencia de la UI.
Ejemplo:

```
click_blue_button
```

> [!WARNING]

* Describe apariencia, no intención

---

### 8.3 No incluir parámetros

> [!IMPORTANT]
> Siempre incluye parámetros relevantes en los eventos.

* Limita el análisis
* Impide segmentación

---

### 8.4 Mezclar idiomas

> [!CAUTION]
> No mezcles idiomas en los nombres de eventos.
Ejemplo:

```
click_ir_pagina
```

> [!WARNING]

* Inconsistencia
* Dificulta mantenimiento

---

## 9. Regla final

> [!IMPORTANT]
> Todo evento debe aportar información útil para entender el comportamiento del usuario.

Si un evento no permite analizar acciones, decisiones o flujos, debe ser replanteado.
