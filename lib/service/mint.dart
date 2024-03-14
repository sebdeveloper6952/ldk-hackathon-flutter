import 'package:get/get.dart';
import 'package:cashu_dart/cashu_dart.dart';

class MintService extends GetxService with CashuListener {
  final mint = IMint(
    mintURL: 'https://cashu.mutinynet.com',
  );

  @override
  void onInvoicePaid(Receipt r) {
    print("the invoice was paid");
    Cashu.redeemEcashFromInvoice(
      mint: mint,
      pr: r.request,
    );
  }

  Future createInvoice() async {
    final receipt = await Cashu.createLightningInvoice(
      mint: mint,
      amount: 1,
    );

    if (receipt == null) {
      return;
    }

    print('request: ${receipt.request}');

    Cashu.addInvoiceListener(this);
  }
}
