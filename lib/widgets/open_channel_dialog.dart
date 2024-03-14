import 'package:flutter/material.dart';
import 'package:ldkhackathon/service/models.dart';

class OpenChannelDialog extends StatefulWidget {
  const OpenChannelDialog({super.key});

  @override
  State<OpenChannelDialog> createState() => _OpenChannelDialogState();
}

class _OpenChannelDialogState extends State<OpenChannelDialog> {
  String _address =
      "02465ed5be53d04fde66c9418ff14a5f2267723810176c9212b722e542dc1afb1b@45.79.52.207:9735";
  int _amountSats = 100000;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.currency_bitcoin,
              ),
            ),
            Center(
              child: Text(
                'Open Channel',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                initialValue: _address,
                decoration: const InputDecoration(
                  labelText: 'Peer Address',
                ),
                onSaved: (v) {
                  _address = v ?? '';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                initialValue: _amountSats.toString(),
                decoration: const InputDecoration(
                  labelText: 'Amount Sats',
                ),
                onSaved: (v) {
                  if (v != null) {
                    _amountSats = int.tryParse(v) ?? 0;
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      OpenChannelDetails(
                        _address,
                        _amountSats,
                      ),
                    );
                  },
                  child: Text(
                    'Submit',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
