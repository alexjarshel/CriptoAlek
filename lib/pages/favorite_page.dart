import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:urubu_do_pix/repositories/favorites_repository.dart';
import 'package:urubu_do_pix/widgets/coin_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<FavoritesRepository>(
          builder: (context, favorites, child){
            return favorites.list.isEmpty
            ? ListTile(
                leading: Icon(Icons.favorite_border_rounded),
                title: Text('You dont have Favorite Coins!'),
              )
            : ListView.builder(itemCount: favorites.list.length, itemBuilder:(_, index){
                return CoinCard(coin : favorites.list[index]);
            } ,);
          }
        ),


      ),
    );
  }
}
