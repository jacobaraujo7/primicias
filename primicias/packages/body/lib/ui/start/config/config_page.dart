import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  void _confirmarExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Tem certeza?'),
            content: const Text(
              'Esta ação é irreversível!\nSua conta e todos os dados associados serão permanentemente excluídos.',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  // lógica de exclusão da conta
                  Navigator.pop(context);
                },
                child: const Text('Excluir Conta'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Configurações', style: theme.textTheme.titleMedium),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Modo Escuro'),
              value: isDarkMode,
              onChanged: (val) {
                // lógica para alternar o tema
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Excluir Conta',
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(Icons.delete, color: Colors.red),
              onTap: () => _confirmarExclusao(context),
            ),
          ],
        ),
      ),
    );
  }
}
