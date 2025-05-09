import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'pergunta': 'Como funciona o sistema de cashback?',
        'resposta':
            'Você recebe uma porcentagem do valor gasto de volta em sua conta para usar em futuras compras.',
      },
      {
        'pergunta': 'Como resgatar meus cupons?',
        'resposta':
            'Basta acessar a aba de Cupons, selecionar um disponível e clicar em "Resgatar". Cupons exigem um nível mínimo para serem resgatados.',
      },
      {
        'pergunta': 'Posso alterar meu CPF cadastrado?',
        'resposta':
            'Não. Por questões de segurança e rastreabilidade, o CPF não pode ser alterado após o cadastro.',
      },
    ];

    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Dúvidas', style: theme.textTheme.titleMedium),
          const SizedBox(height: 24),
          for (final faq in faqs)
            _FaqItem(pergunta: faq['pergunta']!, resposta: faq['resposta']!),
        ],
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String pergunta;
  final String resposta;

  const _FaqItem({required this.pergunta, required this.resposta});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          pergunta,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(resposta),
          ),
        ],
      ),
    );
  }
}
