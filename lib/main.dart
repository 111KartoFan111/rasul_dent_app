import 'package:flutter/material.dart';
import 'navigation_container.dart'; // Импортируем нашу новую "оболочку"

// 
void main() {
  runApp(const DentalApp());
}

class DentalApp extends StatelessWidget {
  const DentalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Немного улучшим тему
        scaffoldBackgroundColor: const Color(0xFFF4F7FA), // Светлый фон
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
        // Было: CardTheme(
        // Стало: CardThemeData(
        cardTheme: CardThemeData(
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      // Устанавливаем MainNavigationScreen как домашнюю страницу
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

