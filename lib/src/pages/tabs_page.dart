import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.actualPage,
      onTap: (i) => navigationModel.actualPage = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navegationModel = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: navegationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      //efecto de arrastre al final
      // physics: BouncingScrollPhysics(),
      children: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        ),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _actualPage = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get actualPage => this._actualPage;

  set actualPage(int value) {
    this._actualPage = value;
    this._pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}