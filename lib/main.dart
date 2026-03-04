import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// ---------- Punto de entrada ----------
// La función main es el primer código que se ejecuta en Flutter.
void main() {
  // runApp inicia la aplicación y coloca el widget proporcionado como
  // raíz del árbol de widgets.
  runApp(const MyApp());
}

// ---------- Widget principal (sin estado) ----------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp es un widget que configura temas, rutas y parámetros
    // globales de la aplicación basados en Material Design.
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la bandera de depuración
      home: CalculatorScreen(), // Pantalla inicial de la calculadora
    );
  }
}

// ---------- Widget con estado para la calculadora ----------
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

// Clase que mantiene el estado de la calculadora
class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = ""; // Guarda la expresión ingresada por el usuario
  String result = "0"; // Guarda el resultado mostrado en pantalla

  // Borra toda la entrada y restablece el resultado a "0"
  void clearAll() {
    setState(() {
      input = "";
      result = "0";
    });
  }

  // Elimina el último carácter de la cadena de entrada
  void deleteOne() {
    if (input.isNotEmpty) {
      setState(() {
        input = input.substring(0, input.length - 1);
      });
    }
  }

  // Maneja la pulsación de cualquier botón de la calculadora
  void buttonPressed(String text) {
    if (text == "C") {
      // Botón de limpiar
      clearAll();
    } else if (text == "⌫") {
      // Botón de retroceso
      deleteOne();
    } else if (text == "=") {
      // Botón de igual: calcular el resultado
      calculateResult();
    } else {
      // Caracter normal: concatenar en la entrada
      setState(() {
        input += text;
      });
    }
  }

  // Convierte la cadena de entrada en un valor numérico
  void calculateResult() {
    try {
      // Reemplaza los símbolos de multiplicación/división por los que
      // entiende el parser (× => *, ÷ => /).
      String finalInput =
          input.replaceAll('×', '*').replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(finalInput); // Analiza la expresión
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        // Limita el resultado a 8 cifras significativas para evitar
        // demasiados decimales.
        result = eval.toStringAsPrecision(8);

        // Si el resultado contiene un punto decimal, eliminamos ceros
        // innecesarios al final y el punto si queda al final.
        if (result.contains('.')) {
          result = result.replaceAll(RegExp(r'0*$'), '');
          result = result.replaceAll(RegExp(r'\.$'), '');
        }
      });
    } catch (e) {
      // Si ocurre un error (p. ej. expresión inválida) mostramos "Error"
      setState(() {
        result = "Error";
      });
    }
  }

  // Construye un botón con estilo según su función (operador, número, etc.)
  Widget buildButton(String text) {
    Color buttonColor;

    // Asigna el color según el tipo de botón
    if (text == "+" || text == "-" || text == "×" || text == "÷") {
      buttonColor = Colors.orange; // Operadores
    } else if (text == "=") {
      buttonColor = Colors.orange; // Igual
    } else if (text == "C") {
      buttonColor = Colors.red; // Limpiar
    } else if (text == "⌫") {
      buttonColor = Colors.grey; // Retroceso
    } else {
      buttonColor = Colors.blue; // Números y punto
    }

    // El botón ocupa todo el espacio disponible (Expanded) y tiene padding
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Construye una fila de botones a partir de una lista de textos
  Widget buildRow(List<String> buttons) {
    return Row(
      children: buttons.map((b) => buildButton(b)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Estructura principal de la interfaz usando Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora DDAPDM"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Área que muestra la expresión ingresada
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              input,
              style: const TextStyle(fontSize: 28),
            ),
          ),
          // Área que muestra el resultado de la operación
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          // Filas con los botones de la calculadora
          buildRow(["1", "2", "3", "÷"]),
          buildRow(["4", "5", "6", "×"]),
          buildRow(["7", "8", "9", "-"]),
          buildRow([".", "0", "+", "="]),
          buildRow(["C", "⌫"]),
        ],
      ),
    );
  }
}
