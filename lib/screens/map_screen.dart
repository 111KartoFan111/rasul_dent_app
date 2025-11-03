import 'package:flutter/material.dart';

// --- 2. Экран Карты (Макет) ---

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- УСЛОВНАЯ КАРТА ---
        // Это контейнер, который имитирует виджет Google Карты
        // Мы не можем показать настоящую карту без API ключа
        Container(
          height: 300,
          color: Colors.grey[300],
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_sharp, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Здесь будет Google Карта',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                Text(
                  '(Требуется настройка API-ключа)',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ),

        // --- СПИСОК КЛИНИК РЯДОМ (СТАТИЧНЫЙ) ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Клиники рядом с вами:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildClinicListItem(
                  'Smile Dental', 'ул. Абая, 15 (0.8 км)', '4.9'),
              _buildClinicListItem(
                  'Ortho Center', 'пр. Республики, 10 (1.2 км)', '4.8'),
              _buildClinicListItem(
                  'Denta Lux', 'ул. Кенесары, 40 (2.5 км)', '4.7'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClinicListItem(String name, String address, String rating) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.local_hospital, color: Colors.red),
        title: Text(name),
        subtitle: Text(address),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.orange, size: 16),
            const SizedBox(width: 4),
            Text(rating),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
