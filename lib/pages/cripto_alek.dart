import 'package:flutter/material.dart';
import 'package:urubu_do_pix/repositories/coin_repository.dart';

class CriptoAlek extends StatelessWidget {
  const CriptoAlek({super.key});

  @override
  Widget build(BuildContext context) {

    final table = CoinRepository.table;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cripto Alek'),
       //backgroundColor: Colors.orange,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int coin){
          return ListTile(
            leading: Image.asset(table[coin].icon),
            title:Text(table[coin].name),
            trailing: Text(table[coin].price.toString()),
          );
        }, 
        padding: EdgeInsets.all(16),
        separatorBuilder: (_,__) =>  Divider(), 
        itemCount: table.length),
        //backgroundColor: Colors.black,
    );
  }
}