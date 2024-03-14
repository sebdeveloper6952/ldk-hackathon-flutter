class Channel {
  Channel(
    this.peerAlias,
    this.inboundSats,
    this.outboundSats,
    this.status,
  );

  final String peerAlias;
  final int inboundSats;
  final int outboundSats;
  final String status;
}

class OpenChannelDetails {
  OpenChannelDetails(
    this.address,
    this.amountSats,
  );

  final String address;
  final int amountSats;
}
