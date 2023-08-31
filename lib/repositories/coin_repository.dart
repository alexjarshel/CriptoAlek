import 'package:urubu_do_pix/models/coin.dart';

class CoinRepository {
  static List<Coin> table = [
    Coin(
        icon: 'images/btc.png',
        name: 'bitcoin',
        acronym: 'BTC',
        price: 164603.08),
    Coin(
        icon: 'images/etherun.png',
        name: 'Etherun',
        acronym: 'ETH',
        price: 9716.08),
    Coin(
      icon: 'images/xrp.png',
      name: 'XRP',
      acronym: 'XRP',
      price: 3.38,
    ),
    Coin(
        icon: 'images/carddano.png',
        name: 'Cardano',
        acronym: 'ADA',
        price: 6.32),
    Coin(
      icon: 'images/usd.png',
      name: 'USD Coin',
      acronym: 'USDC',
      price: 5.08,
    ),
    Coin(
      icon: 'images/ltc.png',
      name: 'LiteCoin',
      acronym: 'LTC',
      price: 3.38,
    )
  ];
}
