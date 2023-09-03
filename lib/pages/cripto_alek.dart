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

  //functioons
  dinamicAppBar() {
    if (selectedCoin.isEmpty) {
      return AppBar(
        title: const Text(
          'Cripto Alek',
        ),
        centerTitle: true,
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selectedCoin = [];
            });
          },
        ),
        title: Text('${selectedCoin.length} selected'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(
            color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
      );
    }
  }

  selectCois(selectedCoin, coin) {
    setState(() {
      if (selectedCoin.contains(table[coin])) {
        selectedCoin.remove(table[coin]);
      } else {
        selectedCoin.add(table[coin]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: dinamicAppBar(),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int coin) {
              return ListTile(
                onTap: () {
                  if (selectedCoin.isNotEmpty) {
                    selectCois(selectedCoin, coin);
                  }
                },
                // -> estilização
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                leading: (selectedCoin.contains(table[coin]))
                    ? const CircleAvatar(
                        child: Icon(Icons.check),
                      )
                    : SizedBox(
                        width: 40,
                        child: Image.asset(table[coin].icon),
                      ),
                title: Text(
                  table[coin].name,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                trailing: Text(real.format(table[coin].price)),
                // -> estilização
                selected: selectedCoin.contains(table[coin]),
                selectedTileColor: Colors.green[50],

                onLongPress: () {
                  selectCois(selectedCoin, coin);
                },
              );
            },
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: table.length),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selectedCoin.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () {},
                label: const Text(
                  'favorite',
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.star),
              )
            : null);
  }
}
