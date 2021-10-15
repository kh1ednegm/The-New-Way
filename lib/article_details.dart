import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/model.dart';
import 'package:news_app/news_feed.dart';
import 'package:news_app/service.dart';


class ArticleDetails extends StatelessWidget {
  final ArticleModel article;
  ArticleDetails({@required this.article});

  String _date(String date) {
    var temp = date.substring(8, 10) +
        '-' +
        date.substring(5, 7) +
        '-' +
        date.substring(0, 4);
    return temp;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height * .6,
                      foregroundDecoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4)
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                          article.urlToImage,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 70,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .75,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200].withOpacity(.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        style: kSearchBarStyle.copyWith(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: kSearchBarStyle.copyWith(color: Colors.white),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.white,
                          ),
                          suffixIcon: Icon(
                              Icons.close_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        onSubmitted: (value) async{
                          articles = NetworkHelper.getArticlesBySearch(value);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .45,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(right: 16.0,bottom: 16,left: 16),
                      child: Text(
                        article.title,
                        softWrap: true,
                        textAlign: Helper.isArabic(article.title)? TextAlign.right : TextAlign.left,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * .02,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Chip(
                                label: Text(
                                  _date(article.publishedAt),
                                ),
                                avatar: Icon(
                                  Icons.schedule,
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                              Chip(
                                label: Text(
                                  article.source.name,
                                ),
                                avatar: Icon(
                                  Icons.remove_red_eye_rounded,
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:16.0),
                            child: Text(
                              article.title,
                              textAlign: Helper.isArabic(article.title)? TextAlign.right : TextAlign.left,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:16.0),
                            child: Text(
                              article.title,
                              textAlign: Helper.isArabic(article.title)? TextAlign.right : TextAlign.left,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
