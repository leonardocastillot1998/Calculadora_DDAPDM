# 📱 Calculadora DDAPDM

Aplicación desarrollada en **Flutter** que permite realizar operaciones
matemáticas básicas:

-   ➕ Suma\
-   ➖ Resta\
-   ✖ Multiplicación\
-   ➗ División

Incluye manejo de decimales, eliminación de ceros innecesarios y control
de errores.

------------------------------------------------------------------------

## 🚀 Características

✅ Operaciones básicas (+, −, ×, ÷)\
✅ Soporte para números decimales\
✅ Botón C (limpiar todo)\
✅ Botón ⌫ (borrar uno por uno)\
✅ Manejo de errores\
✅ Eliminación automática de ceros innecesarios (Ej: 4.5000 → 4.5)\
✅ Diseño con botones de colores personalizados

------------------------------------------------------------------------

## 🛠 Tecnologías utilizadas

-   Flutter
-   Dart
-   Paquete math_expressions

------------------------------------------------------------------------

## 📦 Dependencias

Agregar en `pubspec.yaml`:

``` yaml
dependencies:
  flutter:
    sdk: flutter
  math_expressions: ^2.4.0
```

Luego ejecutar:

``` bash
flutter pub get
```

------------------------------------------------------------------------

## 🧠 Funcionamiento del cálculo

La aplicación utiliza el paquete `math_expressions` para evaluar
expresiones matemáticas.

------------------------------------------------------------------------

## 🔢 Manejo de Decimales

Para evitar resultados como:

4.5000

Se utiliza:

-   toStringAsPrecision(8)
-   Eliminación de ceros innecesarios con expresiones regulares

Ejemplos:

  Operación   Resultado
  ----------- -----------
  9 ÷ 2       4.5
  10 ÷ 2      5
  8 ÷ 3       2.6666667

------------------------------------------------------------------------

## ▶ Cómo Ejecutar el Proyecto

1.  Ejecutar:

``` bash
flutter pub get
flutter run
```

------------------------------------------------------------------------

## 📌 Posibles Mejoras Futuras

-   🌙 Modo oscuro
-   🧠 Historial de operaciones
-   📱 Diseño responsive
-   🎨 Estilo tipo calculadora profesional

------------------------------------------------------------------------

## 👨‍💻 Autor

Proyecto desarrollado como práctica de Flutter para aprendizaje de
interfaces y manejo de estado.
