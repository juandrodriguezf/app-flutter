# RateMyPc - Flutter

Version en Flutter de RateMyPc, una red social para descubrir, calificar y compartir opiniones sobre componentes de computador.

Este repositorio es independiente de la aplicacion Android y se usa para el taller de la semana 16. No usa Firebase ni backend: los datos de las pantallas son locales.

## Pantallas

1. Login
2. Feed de componentes
3. Detalle de componente
4. Resenas de un componente
5. Perfil
6. Comparador

Las pantallas se muestran desde un menu inferior temporal, sin un sistema de navegacion por rutas.

## Stack

- Flutter 3.50.0 (stable)
- Dart 3.14.0
- Material 3 mediante `material_ui`
- Datos quemados en Dart
- Imagenes locales en `assets/`

## Estructura

```text
lib/
  main.dart
  app_shell.dart
  theme/
  models/
  data/
  widgets/
  screens/
assets/
  images/
    components/
    builds/
test/
```

## Requisitos

- Flutter 3.50 o superior.
- Android SDK y un emulador o dispositivo para probar.
- Opcional: VS Code con las extensiones Dart y Flutter.

## Ejecutar

```powershell
flutter pub get
flutter run
```

Para compilar un APK de depuracion:

```powershell
flutter build apk --debug
```

## Verificacion

```powershell
flutter analyze
flutter test
```

## Notas

- El paquete tecnico del proyecto es `flutter_app` y el identificador de Android es `com.example.flutter_app`.
- El nombre visible de la aplicacion es **RateMyPc**.
- Las imagenes de componentes provienen de los datos de ejemplo de la aplicacion Android y se usan solo con fines academicos.

## Autor

Juan Rodriguez
