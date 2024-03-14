import 'package:flutter/material.dart';
import 'package:ldkhackathon/service/models.dart';
import 'package:ldkhackathon/widgets/qr_code_dialog.dart';
import 'package:flutter/services.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          address,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.outlined(
              onPressed: () {
                showDialog<OpenChannelDetails>(
                  context: context,
                  builder: (ctx) {
                    return QrCodeDialog(
                      data: address,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.qr_code,
                size: 15,
              ),
            ),
            IconButton.outlined(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text: address,
                  ),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Address copied to clipboard"),
                  ));
                }
              },
              icon: const Icon(
                Icons.copy,
                size: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
