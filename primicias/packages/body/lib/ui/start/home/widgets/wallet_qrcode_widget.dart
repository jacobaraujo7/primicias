import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletQrCodeDialog extends StatelessWidget {
  final String qrData;

  const WalletQrCodeDialog({required this.qrData, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Mostre este QR Code ao estabelecimento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            QrImageView(data: qrData, size: 200, backgroundColor: Colors.white),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }
}
