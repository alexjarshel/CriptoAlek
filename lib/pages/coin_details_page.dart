import 'package:flutter/material.dart';
import 'package:urubu_do_pix/models/coin.dart';

class CoinDetails extends StatefulWidget {
  Coin coin;
  CoinDetails({super.key, required this.coin});

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
      ),
      body: Column(
        children: [
          Divider(),
          Row(
            children: [
              SizedBox(
                child: Image.asset(widget.coin.icon),
                width: 50,
                )
            ],
          )
        ],
      ),    
    );
  }
}
