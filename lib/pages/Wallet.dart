import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:urubu_do_pix/configs/app_setings.dart';
import 'package:urubu_do_pix/repositories/account_repoitory.dart';

import '../models/position.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPage();
}

class _WalletPage extends State<WalletPage> {
  int index = 0;
  double totalWallet = 0;
  double saldo = 0;
  late NumberFormat real;
  late AccountRepository account;

  String graphicLabel = '';
  double graphicValue = 0;
  List<Position> wallet = [];

  @override
  Widget build(BuildContext context) {
    account = context.watch<AccountRepository>();
    final loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    saldo = account.saldo;

    setTtoalWallet();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Wallet Value',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              real.format(totalWallet),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
              ),
            ),
            graphicload(),
          ],
        ),
      ),
    );
  }

  
setTtoalWallet(){
  final walletList = account.wallet;
  setState(() {
    totalWallet = account.saldo;
    for(var position in walletList){
      totalWallet += position.coin.price * position.quantity;
    } 
  });
}

setGraphicData(int index){
  if(index < 0) return;

  if(index == wallet.length){
    graphicLabel = 'Saldo';
    graphicValue = account.saldo;
  }else{
    graphicLabel = wallet[index].coin.name;
    graphicValue = wallet[index].coin.price * wallet[index].quantity;
  }

}

loadWallett(){
  setGraphicData(index);
  wallet = account.wallet;
  final listLength = wallet.length + 1;

  return List.generate(listLength, (i) {
    final isTouched = i == index;
    final isSaldo = i == listLength -1;
    final fontSize = isTouched ? 18.0 : 14.0;
    final radius = isTouched ? 60.0 : 50.0;
    final color = isTouched ? Colors.tealAccent : Colors.tealAccent[400]; 

    double porcentage = 0;

    if(!isSaldo){
      porcentage = wallet[i].coin.price * wallet[i].quantity / totalWallet;
    }else{
      porcentage = (account.saldo > 0) ? account.saldo / totalWallet : 0;
    }

    porcentage *= 100;

    return PieChartSectionData(
      color: color,
      value: porcentage,
      title: '${porcentage.toStringAsFixed(0)}',
      radius: radius,
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      )
    );
  });
}

graphicload() {
  return (account.saldo <= 0)
  ? Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  )
  :
  Stack(
    alignment: Alignment.center,
    children: [
      AspectRatio(aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sectionsSpace: 10,
          centerSpaceRadius: 110,
          sections: loadWallett(),
          pieTouchData: PieTouchData(
            touchCallback: (touch) => setState(() {
              index = touch.touchedSection!.touchedSectionIndex;
              setGraphicData(index);
            }),
          )
        )
      ),
      ),
      Column(
        children: [
          Text(graphicLabel, style: TextStyle(
            fontSize: 20, color: Colors.teal,
          ),),
          Text(
            real.format(graphicValue),
            style: TextStyle(
              fontSize: 28,
            ),
          )

        ],
      )
    ],
  );
}



}
