import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      'Você ganhou R\$ 5,00 de cashback na Padaria Central!',
      'Seu cupom de R\$ 10,00 está prestes a expirar!',
      'Parabéns! Você subiu para o nível Ouro no programa de pontos.',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notificações'), centerTitle: true),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(notifications[index]),
            onTap: () {
              // ação ao tocar na notificação (se houver)
            },
          );
        },
      ),
    );
  }
}
