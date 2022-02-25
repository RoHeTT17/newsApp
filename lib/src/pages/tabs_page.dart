//Pantalla que contendra la referencia a los tabs

import 'package:appnews/src/pages/tab1_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => new _NavegationModel(),
      child: const Scaffold(
        body: _Tabs(),
        bottomNavigationBar: _NavigationBar(),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({  Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final tabProvider = Provider.of<_NavegationModel>(context);

    return BottomNavigationBar(
      currentIndex: tabProvider.getActualPage,
      onTap: (index) => tabProvider.setActualPage = index,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ]
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({  Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final _tabProvider = Provider.of<_NavegationModel>(context);
    
    return PageView(
      // physics: BouncingScrollPhysics(),
      //Bloquear que no pueda cambiar entre pantallas con el scroll
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabProvider.getPageController,
      children: [
          Tab1Screen(),
          Container(color: Colors.green,)
    
      ],
    );
  }
}

class _NavegationModel extends ChangeNotifier{

  int _actualPage = 0;
  PageController _pageController = new PageController();


  int get getActualPage => this._actualPage;
 /*
  //Así no sirve
  get getActualPage {
    this._actualPage;
  } */

  set setActualPage (int index){
      this._actualPage = index;
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeOut );
      notifyListeners();
   }


  PageController get getPageController => this._pageController;



}