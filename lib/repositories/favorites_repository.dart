import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:urubu_do_pix/models/coin.dart';

import '../Adapter/coin_hive_adapter.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Coin> _list = [];
  late LazyBox box;

  FavoritesRepository(){
    _startRespository();
  }
  
  _startRespository() async{
    await _openbox();
    await _readFavorites();
  }

  _openbox() async{
    Hive.registerAdapter(CoinHiveAdapter());
    box = await Hive.openLazyBox<Coin>('favorite_coins');
  }

  _readFavorites() async{
    box.keys.forEach((coin) async{
      Coin c = await box.get(coin);
      _list.add(c);
      notifyListeners();
    });
  }



  UnmodifiableListView<Coin> get list => UnmodifiableListView(_list);

  saveAll(List<Coin> coins){
    coins.forEach((coin) { 
      if(! _list.any((element) => element.acronym == coin.acronym)){
        _list.add(coin);
        box.put(coin.acronym, coin);
      }
    });
    notifyListeners();
  }

  remove(Coin coin){
    _list.remove(coin);
    box.delete(coin.acronym);
    notifyListeners();
  }




  
}