import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashbackPage extends StatelessWidget {
  const CashbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd/MM/yyyy');
    final items = [
      {
        'title': 'Cashback recebido - Padaria Central',
        'value': 5.00,
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'expire': DateTime.now().add(const Duration(days: 30)),
      },
      {
        'title': 'Cashback usado - Cupom R\$10',
        'value': -10.00,
        'date': DateTime.now().subtract(const Duration(days: 5)),
        'expire': null,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Cashback'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = items[index];
          final value = item['value'] as double;
          final expire = item['expire'] as DateTime?;
          return ListTile(
            leading: Icon(
              value > 0 ? Icons.arrow_downward : Icons.arrow_upward,
              color: value > 0 ? Colors.green : Colors.red,
            ),
            title: const Text('Transação de Cashback'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data: ${f.format(item['date'] as DateTime)}'),
                if (expire != null)
                  Text(
                    'Expira em: ${f.format(expire)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            trailing: Text(
              '${value > 0 ? '+' : ''}R\$ ${value.toStringAsFixed(2)}',
              style: TextStyle(
                color: value > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
