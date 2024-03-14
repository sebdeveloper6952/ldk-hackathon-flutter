import 'package:cashu_dart/business/wallet/cashu_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ldkhackathon/service/mint.dart';
import 'package:ldkhackathon/service/models.dart';
import 'package:ldkhackathon/service/node.dart';
import 'package:ldkhackathon/widgets/address_card.dart';
import 'package:ldkhackathon/widgets/channel_card.dart';
import 'package:ldkhackathon/widgets/open_channel_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future setupComplete = CashuManager.shared.setup(
    'ldkhackathon',
    defaultMint: ['https://cashu.mutinynet.com'],
  );

  late MintService _mint;
  late NodeService _node;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _mintWidget() {
    return GetX<NodeService>(
      builder: (svc) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balance',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Center(
                    child: Text(
                      svc.channelBalance.toString(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Center(
                    child: Text(
                      'sats',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: () {
                          _mint.createInvoice();
                        },
                        icon: Icon(
                          Icons.arrow_downward,
                        ),
                        label: Text('Receive'),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      FilledButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_outward,
                        ),
                        label: Text('Send'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _nodeWidget() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Onchain',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  FloatingActionButton.small(
                    onPressed: () async {
                      await _node.createOnchainAddress();
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
              Obx(
                () => Column(
                  children: _node.onchainAddresses
                      .map(
                        (a) => AddressCard(
                          address: a,
                        ),
                      )
                      .toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Channels',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  FloatingActionButton.small(
                    onPressed: () async {
                      final chanDetails = await showDialog<OpenChannelDetails>(
                        context: context,
                        builder: (ctx) {
                          return const OpenChannelDialog();
                        },
                      );

                      if (chanDetails != null) {
                        await _node.createChannel(chanDetails);
                      }
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
              Obx(
                () => Column(
                  children: _node.channels
                      .map(
                        (c) => ChannelCard(
                          channel: c,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _frameWidget() {
    switch (_selectedIndex) {
      case 1:
        return _nodeWidget();
    }

    return _mintWidget();
  }

  @override
  void initState() {
    super.initState();
    _mint = Get.find<MintService>();
    _node = Get.find<NodeService>();

    _node.fetchChannels();
    _node.fetchOnchainAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyNuts',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Mint',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Node',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: FutureBuilder(
        future: setupComplete,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: _frameWidget(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
