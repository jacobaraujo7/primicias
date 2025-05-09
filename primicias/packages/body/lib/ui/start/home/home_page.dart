import 'package:body/config/routes/route_extension.dart';
import 'package:body/ui/start/home/cashback/cashback_page.dart';
import 'package:body/ui/start/home/cupons/cupons_page.dart';
import 'package:body/ui/start/home/partners/partners_page.dart';
import 'package:body/ui/start/home/widgets/scanner_widget.dart';
import 'package:body/ui/start/home/widgets/wallet_qrcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:uicons/uicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _scannerInvoice() async {
    final result = await context.push(const ScannerWidget());

    if (result is! String) {
      return;
    }
    print('Code: $result');
  }

  void _showWalletQrCodeDialog() {
    showDialog(
      context: context,
      builder: (_) => WalletQrCodeDialog(qrData: 'qrData'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Olá, Eurides!', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        Cashback(onUsePressed: _showWalletQrCodeDialog),
        const SizedBox(height: 24),
        Text('Pontuação', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Points(),
        const SizedBox(height: 24),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 4 / 2.7,
          children: [
            _HomeButton(
              icon: UIcons.regularRounded.qrcode,
              label: 'Pontuar',
              isSelected: true,
              onTap: _scannerInvoice,
            ),
            _HomeButton(
              icon: UIcons.solidRounded.coins,
              label: 'Cashback',
              iconThemeData: IconThemeData(color: Colors.yellow[700], size: 36),
              onTap: () {
                context.push(const CashbackPage());
              },
            ),
            _HomeButton(
              icon: UIcons.solidRounded.ticket,
              label: 'Cupons',
              iconThemeData: IconThemeData(color: Colors.blue[700], size: 36),
              onTap: () {
                context.push(const CuponsPage());
              },
            ),
            _HomeButton(
              icon: UIcons.solidRounded.handshake,
              label: 'Parceiros',
              iconThemeData: IconThemeData(
                color: Colors.deepOrangeAccent,
                size: 36,
              ),
              onTap: () {
                context.push(const PartnersPage());
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final IconThemeData? iconThemeData;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _HomeButton({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.iconThemeData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final backgroundColor = isSelected ? colors.primary : colors.surface;
    final textColor =
        isSelected ? colors.primaryContainer : colors.onSecondaryContainer;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: iconThemeData ?? IconThemeData(color: textColor, size: 36),
              child: Icon(icon),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class Cashback extends StatelessWidget {
  final VoidCallback onUsePressed;
  const Cashback({super.key, required this.onUsePressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cashback',
                style: TextStyle(color: colors.primaryContainer),
              ),
              const SizedBox(height: 8),
              Text(
                'R\$ 200,00',
                style: TextStyle(
                  color: colors.onPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: onUsePressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wallet, color: colors.primaryContainer, size: 48),
                Text('USAR', style: TextStyle(color: colors.primaryContainer)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final int currentPoints = 413;
    final int maxPoints = 1000;
    final int nextLevel = 4;
    final int currentLevel = 3;
    final double progress = currentPoints / maxPoints;
    final int missingPoints = maxPoints - currentPoints;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Você está no nível $currentLevel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6,
                      backgroundColor: colors.secondaryContainer,
                      color: colors.primary,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$currentPoints',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        '/1.000',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Alcance o nível $nextLevel acumulando mais $missingPoints pontos.',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
