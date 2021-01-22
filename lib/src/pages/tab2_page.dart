import 'package:flutter/material.dart';
import 'package:news_app/src/models/category.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/services/news_service.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final newsService = Provider.of<NewsService>(context);
    
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _CategoriesList(),
            Expanded(
                child: NewsList(newsService.getArticlesFromSelectedCategory)
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final categoryName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                SizedBox(height: 5),
                Text(
                    '${categoryName[0].toUpperCase()}${categoryName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        //video 292. min 8:20
        // final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: newsService.selectedCategory == category.name
              ? myTheme.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
