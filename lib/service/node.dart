import 'package:get/get.dart';
import 'package:ldkhackathon/number_format.dart';
import 'package:ldkhackathon/service/models.dart';

// send y receive ecash
//

class NodeService extends GetxService {
  NodeService({
    required url,
  }) : _url = url;

  final _url;
  final RxList<Channel> _channels = <Channel>[].obs;
  final RxList<String> _onchainAddresses = <String>[].obs;

  RxList<Channel> get channels => _channels;
  RxList<String> get onchainAddresses => _onchainAddresses;

  final _chanBalance = 0;
  String get channelBalance => numberFormatter.format(
        _channels.fold(_chanBalance, (prev, c) => prev + c.outboundSats),
      );

  Future<void> fetchChannels() async {
    return Future.delayed(
      const Duration(
        milliseconds: 1500,
      ),
      () {
        _channels.value = <Channel>[
          Channel(
            'mutiny',
            87521,
            6526,
            "OPEN",
          ),
          Channel(
            'rugpuller',
            87521,
            91263,
            "OPEN",
          ),
        ];
      },
    );
  }

  Future<void> createChannel(OpenChannelDetails details) async {
    return Future.delayed(
      const Duration(
        milliseconds: 1000,
      ),
      () {
        _channels.add(
          Channel(
            details.address,
            details.amountSats,
            0,
            "PENDING",
          ),
        );
      },
    );
  }

  Future<void> fetchOnchainAddresses() async {
    return Future.delayed(
      const Duration(
        milliseconds: 1500,
      ),
      () {
        _onchainAddresses.value = <String>[
          'tb1qm4uf7lw9semkvvsyh235jfcz4e8avqyrdq7wug',
        ];
      },
    );
  }

  Future<void> createOnchainAddress() async {
    return Future.delayed(
      const Duration(
        milliseconds: 1000,
      ),
      () {
        _onchainAddresses.add("tb1qm4uf7lw9semkvvsyh235jfcz4e8avqyrdq7wug");
      },
    );
  }
}
