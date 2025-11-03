import 'package:flutter/material.dart';

// --- 3. Экран Записей (Макет) ---

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Используем TabBar для разделения "Предстоящие" и "Прошедшие"
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Нам нужен свой AppBar внутри Scaffold'а, чтобы разместить TabBar
          toolbarHeight: 0, // Убираем высоту, так как AppBar уже есть
          bottom: const TabBar(
            tabs: [
              Tab(text: 'ПРЕДСТОЯЩИЯ'),
              Tab(text: 'ПРОШЕДШИЕ'),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            _buildAppointmentsList(isUpcoming: true),
            _buildAppointmentsList(isUpcoming: false),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsList({required bool isUpcoming}) {
    // Статичные данные
    final items = isUpcoming
        ? [
            ('Пятница, 7 Ноября, 14:30', 'Плановый осмотр', 'Др. Аскаров')
          ]
        : [
            ('12 Сентября 2024', 'Лечение кариеса', 'Др. Иванова'),
            ('3 Мая 2024', 'Профессиональная чистка', 'Др. Аскаров'),
            ('15 Февраля 2024', 'Консультация ортодонта', 'Др. Беков'),
          ];

    if (items.isEmpty) {
      return const Center(child: Text('Нет записей'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            leading: Icon(
              isUpcoming
                  ? Icons.watch_later_outlined
                  : Icons.check_circle_outline,
              color: isUpcoming ? Colors.blue : Colors.green,
            ),
            title: Text(item.$1), // Дата и время
            subtitle: Text('${item.$2} \n${item.$3}'), // Услуга и Врач
            isThreeLine: true,
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          ),
        );
      },
    );
  }
}
