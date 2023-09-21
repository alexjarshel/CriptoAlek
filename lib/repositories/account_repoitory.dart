import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../DataBase/db.dart';
import '../models/position.dart';

class AccountRepository extends ChangeNotifier{
  late Database db;

  List<Position> _wallet = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Position> get wallet => _wallet;

  AccountRepository(){
        _initRepository();
  }

  _initRepository() async{
    await getSaldo();
  }

  getSaldo() async{
    db = await DB.instance.database;
    List account = await db.query('conta', limit: 1);
    _saldo = account.first['balance'];
    notifyListeners();
  }

  setSaldo(double valor) async{
    db=await DB.instance.database;
    db.update('conta',{
      'balance' : valor,
    });
    _saldo = valor;
    notifyListeners();
  }
}