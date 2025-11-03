import 'package:flutter/material.dart';

// --- 4. Экран Профиля (Макет) ---

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // --- Шапка профиля ---
        Container(
          padding: const EdgeInsets.all(24.0),
          color: Colors.white,
          child: const Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Text('A',
                    style: TextStyle(fontSize: 40, color: Colors.white)),
              ),
              SizedBox(height: 16),
              Text(
                'Айдос Муратов',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'aidos.muratov@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),

        // --- Раздел "Электронная карта" ---
        _buildSectionTitle(context, 'Электронная карта'),
        _buildProfileCard('История лечения', 'Просмотреть всю историю', Icons.history),
        _buildProfileCard('План лечения от ИИ', 'Обновлено 2 дня назад',
            Icons.bar_chart_outlined),
        _buildProfileCard(
            'Мои снимки (Рентген)', '3 файла', Icons.image_outlined),

        // --- Раздел "Настройки" ---
        _buildSectionTitle(context, 'Настройки'),
        _buildProfileCard('Управление уведомлениями', '', Icons.notifications_outlined),
        _buildProfileCard('Выйти из аккаунта', '', Icons.logout, Colors.red),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _buildProfileCard(String title, String subtitle, IconData icon,
      [Color? iconColor]) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.blue),
        title: Text(title),
        subtitle: subtitle.isEmpty ? null : Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {},
      ),
    );
  }
}
