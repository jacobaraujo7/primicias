import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final partners = [
      {
        'nome': 'Padaria Central',
        'endereco': 'Rua das Flores, 123',
        'telefone': '(44) 1234-5678',
        'mapUrl': 'https://maps.google.com/?q=Rua das Flores, 123',
        'horario': 'Seg a Sab: 07:00 - 18:00',
        'imagem':
            'https://www.otempo.com.br/adobe/dynamicmedia/deliver/dm-aid--184fe688-44cd-420b-ab6f-69def0c0bbac/economia-drogaria-araujo-araujo-drugstore-exoansao-da-araujo-para-o-interior-lojas-da-araujo-em-mg-araujo-118-anos-1713339540.jpg?preferwebp=true&quality=90&width=1200',
      },
      {
        'nome': 'Restaurante Sabor e Arte',
        'endereco': 'Av. Brasil, 999',
        'telefone': '(44) 9876-5432',
        'mapUrl': 'https://maps.google.com/?q=Av. Brasil, 999',
        'horario': 'Todos os dias: 11:00 - 23:00',
        'imagem':
            'https://www.otempo.com.br/adobe/dynamicmedia/deliver/dm-aid--184fe688-44cd-420b-ab6f-69def0c0bbac/economia-drogaria-araujo-araujo-drugstore-exoansao-da-araujo-para-o-interior-lojas-da-araujo-em-mg-araujo-118-anos-1713339540.jpg?preferwebp=true&quality=90&width=1200',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Parceiros'), centerTitle: true),
      body: ListView.builder(
        itemCount: partners.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final partner = partners[index];
          return _PartnerCard(partner: partner);
        },
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  final Map<String, String> partner;

  const _PartnerCard({required this.partner});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(partner['imagem']!),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partner['nome']!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  partner['endereco']!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  partner['horario']!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.phone),
                      onPressed: () {
                        launchUrl(Uri.parse('tel:${partner['telefone']}'));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.map),
                      onPressed: () {
                        launchUrl(Uri.parse(partner['mapUrl']!));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: const Text('Horário de Funcionamento'),
                                content: Text(partner['horario']!),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Fechar'),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
