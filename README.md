# RateMyPc - Flutter

Versión en Flutter de RateMyPc, una red social para descubrir, calificar y compartir opiniones sobre componentes de computador. Es un port académico de la aplicación Android del curso de Computación Móvil.

Este repositorio es independiente de la aplicación Android y no usa Firebase ni backend. Las seis pantallas consumen datos de ejemplo locales y las imágenes están empaquetadas en `assets/`.

## Pantallas

1. **Login**: validación local, visibilidad de contraseña y diálogo de recuperación.
2. **Feed**: tabs Explorar/Siguiendo, búsqueda, categorías, favoritos y comparación.
3. **Detalle**: imagen, calificación, especificaciones y acciones de reseña/comparación.
4. **Reseñas**: filtros por fuente, distribución de calificaciones, likes y eliminación de reseñas propias.
5. **Perfil**: avatar, datos de ejemplo, estadísticas, equipos y reseñas del usuario.
6. **Comparador**: tabla de hasta tres componentes con mejores valores y limpieza.

## Navegación

Se usa `Navigator` con `MaterialPageRoute`, sin rutas nombradas ni `go_router`.

```text
Login --pushReplacement--> MainShell
MainShell (NavigationBar): Feed | Comparador | Perfil
Feed --push--> Detalle
Feed --push--> Reseñas
Detalle --push--> Reseñas
Perfil --pushAndRemoveUntil--> Login (cerrar sesión)
```

- `MainShell` conserva el estado de las pestañas con `IndexedStack`.
- Las acciones que no tienen pantalla en la demo muestran un `SnackBar`.

## Stack

- Flutter 3.50.0 (stable)
- Dart 3.14.0
- Material 3 mediante `material_ui`
- Sin paquetes externos de estado, red o navegación

## Estructura

```text
lib/
  main.dart
  main_shell.dart
  theme/app_theme.dart
  models/
    componente.dart
    resena.dart
  data/sample_data.dart
  state/app_state.dart
  widgets/
    build_card.dart
    component_image.dart
    review_item_card.dart
    star_rating.dart
  screens/
    login_screen.dart
    feed_screen.dart
    detalle_screen.dart
    resenas_screen.dart
    perfil_screen.dart
    comparador_screen.dart
assets/
  images/
    logo.png
    components/
    builds/
test/
  app_state_test.dart
  screens_test.dart
  smoke_test.dart
```

## Estado

- `AppState` (`ChangeNotifier`) guarda favoritos, comparación, likes y reseñas ocultas.
- `AppStateScope` (`InheritedNotifier`) comparte ese estado entre las rutas.
- El estado de cada pantalla (búsqueda, filtros, tabs y diálogos) se maneja con `setState`.
- No se usan paquetes de gestión de estado.

## Datos de ejemplo

- 8 componentes y 33 reseñas en `lib/data/sample_data.dart`.
- Imágenes locales en `assets/images/components/` y `assets/images/builds/`.
- Dos reseñas están marcadas como del usuario demo para mostrar el menú de eliminación.
- El perfil usa datos de ejemplo: Juan Rodríguez, 2 reseñas, 48 seguidores y 23 siguiendo.

## Requisitos

- Flutter 3.50 o superior.
- Android SDK y un emulador o dispositivo para probar.
- Opcional: VS Code con las extensiones Dart y Flutter.

## Ejecutar

```powershell
flutter pub get
flutter run
```

Para elegir un dispositivo:

```powershell
flutter devices
flutter run -d <id-del-dispositivo>
```

## Verificación

```powershell
flutter analyze
flutter test
flutter build apk --debug
```

El APK de depuración queda en `build/app/outputs/flutter-apk/app-debug.apk`.

## Notas

- El paquete técnico es `flutter_app` y el identificador de Android es `com.example.flutter_app`.
- El nombre visible es **RateMyPc**.
- La app no incluye mapa, autenticación real, Firebase ni backend.
- Las imágenes se usan solo con fines académicos.

## Autor

Juan Rodriguez
