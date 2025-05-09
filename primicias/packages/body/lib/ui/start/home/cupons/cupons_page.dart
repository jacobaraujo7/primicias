import 'package:flutter/material.dart';

class CuponsPage extends StatelessWidget {
  const CuponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int userLevel = 3;

    final cuponsDisponiveis = [
      {
        'titulo': 'R\$5 de desconto',
        'validade': now.add(const Duration(days: 3)),
        'nivelMinimo': 2,
        'resgatado': false,
      },
      {
        'titulo': 'R\$10 OFF acima de R\$50',
        'validade': now.add(const Duration(days: 10)),
        'nivelMinimo': 4,
        'resgatado': false,
      },
    ];

    final cuponsResgatados = [
      {
        'titulo': 'R\$5 de desconto',
        'validade': now.add(const Duration(days: 3)),
        'usado': false,
      },
      {
        'titulo': 'Entrega grátis',
        'validade': now.subtract(const Duration(days: 1)),
        'usado': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Cupons'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Disponíveis',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...cuponsDisponiveis.map((cupom) {
            final liberado = userLevel >= (cupom['nivelMinimo'] as int);
            return _CupomItem(
              titulo: cupom['titulo'] as String,
              validade: cupom['validade'] as DateTime,
              status: 'Disponível',
              acao:
                  liberado
                      ? ElevatedButton(
                        onPressed: () {},
                        child: const Text('Resgatar'),
                      )
                      : null,
              extraInfo: 'Nível ${cupom['nivelMinimo']}',
            );
          }),
          const SizedBox(height: 24),
          const Text(
            'Resgatados',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...cuponsResgatados.map((cupom) {
            final bool expirado = (cupom['validade'] as DateTime).isBefore(now);
            final bool usado = cupom['usado'] as bool;
            return _CupomItem(
              titulo: cupom['titulo'] as String,
              validade: cupom['validade'] as DateTime,
              status: expirado ? 'Expirado' : 'Válido',
              acao:
                  usado || expirado
                      ? const Text(
                        'Indisponível',
                        style: TextStyle(color: Colors.grey),
                      )
                      : ElevatedButton(
                        onPressed: () {},
                        child: const Text('Usar'),
                      ),
            );
          }),
        ],
      ),
    );
  }
}

class _CupomItem extends StatelessWidget {
  final String titulo;
  final DateTime validade;
  final String status;
  final Widget? acao;
  final String? extraInfo;

  const _CupomItem({
    required this.titulo,
    required this.validade,
    required this.status,
    this.acao,
    this.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.local_activity),
        title: Text(titulo),
        subtitle: Text(
          '$status até: ${validade.toString().split(" ").first}${extraInfo != null ? ' - $extraInfo' : ''}',
        ),
        trailing: acao,
      ),
    );
  }
}
