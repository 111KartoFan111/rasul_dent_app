import 'package:flutter/material.dart';

// --- 1. Главный экран (Макет) ---

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Добро пожаловать, \nАйдос!', // Используем статичное имя
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),

        // Карточка "Следующая запись"
        _buildNextAppointmentCard(context),

        const SizedBox(height: 24),
        Text(
          'Совет от ИИ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),

        // Карточка "Совет от ИИ"
        _buildAiTipCard(),
      ],
    );
  }

  Widget _buildNextAppointmentCard(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.blue[800], // Яркая карточка
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ваша следующая запись:',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            const Text(
              'Пятница, 7 Ноября, 14:30',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'Клиника "Smile Dental", Др. Аскаров',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue[800],
              ),
              onPressed: () {},
              child: const Text('Подробнее'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAiTipCard() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline,
            color: Colors.orange, size: 40),
        title: const Text('Не забывайте про зубную нить!'),
        subtitle: const Text(
            'ИИ-анализ вашей карты показывает, что регулярное использование нити снизит риск кариеса на 30%.'),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {},
      ),
    );
  }
}
