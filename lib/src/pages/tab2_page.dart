import 'package:flutter/material.dart';
import 'package:news_app/src/models/category.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/services/news_service.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [Expanded(child: _CategoriesList())],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {

        final categoryName = categories[index].name;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _CategoryButton(categories[index].icon),
              SizedBox(height: 5),
              Text('${categoryName[0].toUpperCase()}${categoryName.substring(1)}')
            ],
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final IconData categoryIcon;

  const _CategoryButton(this.categoryIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categoryIcon, color: Colors.black54,),
      ),
    );
  }
}
