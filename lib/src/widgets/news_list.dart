import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(
          newArticle: this.news[index],
          index: index,
        );
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article newArticle;
  final int index;

  const _New({@required this.newArticle, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(newArticle, index),
        _TitleCard(newArticle),
        _ImageCard(newArticle),
        _BodyCard(newArticle),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article newArticle;

  const _BodyCard(this.newArticle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(newArticle.description != null ? newArticle.description : ''),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article newArticle;

  const _ImageCard(this.newArticle);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/giphy.gif'),
          image: newArticle.urlToImage != null
              ? NetworkImage(newArticle.urlToImage)
              : AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article newArticle;

  const _TitleCard(this.newArticle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(newArticle.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article newArticle;
  final int index;

  const _TopBarCard(this.newArticle, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: myTheme.accentColor)),
          Text('${newArticle.source.name}. '),
        ],
      ),
    );
  }
}
