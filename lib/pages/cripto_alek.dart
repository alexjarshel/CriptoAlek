import 'package:flutter/material.dart';
import 'package:urubu_do_pix/models/coin.dart';
import 'package:urubu_do_pix/repositories/coin_repository.dart';
import 'package:intl/intl.dart';

class CriptoAlek extends StatefulWidget {
  const CriptoAlek({super.key});

  @override
  State<CriptoAlek> createState() => _CriptoAlekState();
}

class _CriptoAlekState extends State<CriptoAlek> {
  final table = CoinRepository.table;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Coin> selectedCoin = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cripto Alek'),
        //backgroundColor: Colors.orange,
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int coin) {
            return ListTile(
              // -> estilização
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              leading:SizedBox(
                width: 40,
                child: Image.asset(table[coin].icon),
              ),
              title: Text(
                table[coin].name,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              trailing: Text(real.format(table[coin].price)),
              // -> estilização
              selected: selectedCoin.contains(table[coin]),
              selectedTileColor: Colors.green[50],

              onLongPress: () {
                setState(() {
                  if (selectedCoin.contains(table[coin])) {
                    print('entrou no IF');
                    selectedCoin.remove(table[coin]);
                  } else {
                    print('entrou no ELSE');
                    selectedCoin.add(table[coin]);
                    print(table[coin].acronym);
                    print(selectedCoin[0].acronym);
                  }
                });
              },
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => Divider(),
          itemCount: table.length),
      //backgroundColor: Colors.black,
    );
  }
}
