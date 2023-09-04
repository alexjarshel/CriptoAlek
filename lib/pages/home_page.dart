import 'package:flutter/material.dart';
import 'package:urubu_do_pix/pages/cripto_alek.dart';
import 'package:urubu_do_pix/pages/favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int actualPage = 0;
  late PageController pc;

  setActualPage(page){
    setState(() {
      actualPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: actualPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setActualPage,
        children: [
          CriptoAlek(),
          FavoritesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: actualPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites')
        ],
        onTap: (page) {
          pc.animateToPage(
            page,
            duration: Duration(microseconds: 400),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
