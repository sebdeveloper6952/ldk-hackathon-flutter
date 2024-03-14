import 'package:flutter/material.dart';
import 'package:ldkhackathon/number_format.dart';
import 'package:ldkhackathon/service/models.dart';
import 'package:intl/intl.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({
    super.key,
    required this.channel,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: channel.status == "OPEN"
              ? const Color.fromARGB(255, 69, 119, 75)
              : const Color.fromARGB(255, 164, 155, 75),
          child: Icon(
            channel.status == "OPEN" ? Icons.check : Icons.pending_outlined,
            size: 15,
            color: channel.status == "OPEN"
                ? Colors.green[500]
                : Colors.yellow[500],
          ),
        ),
        title: Text(channel.peerAlias),
        subtitle: Row(
          children: [
            const Icon(
              Icons.arrow_downward,
              size: 20,
            ),
            Text('${numberFormatter.format(channel.inboundSats)} sats'),
            const Icon(
              Icons.arrow_upward,
              size: 20,
            ),
            Text('${numberFormatter.format(channel.outboundSats)} sats'),
          ],
        ),
      ),
    );
  }
}
