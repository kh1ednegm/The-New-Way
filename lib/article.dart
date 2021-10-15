import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/article_details.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/model.dart';

class Article extends StatelessWidget {
  final ArticleModel articleModel;

  Article({@required this.articleModel});



  @override
  Widget build(BuildContext context) {
    if(articleModel.flag == 1 || articleModel.flag == 2){
      return Article2(article: articleModel);
    }
    else {
      return InkWell(
        onTap: () {
          print(articleModel.publishedAt);
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticleDetails(article: articleModel),
              ));
        },
        child: Container(

          height: 100,
          padding: EdgeInsets.only(right: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                  imageUrl: articleModel.urlToImage,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Image.asset("assets/images/noimage.png"),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      articleModel.title,
                      textAlign: Helper.isArabic(articleModel.title)? TextAlign.right : TextAlign.left,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: articleModel.title.length >= 90? 13 : 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Icon(
                                Icons.schedule_outlined,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                            Text(
                              Helper.date(articleModel.publishedAt),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Icon(
                                Icons.remove_red_eye_rounded,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                            Text(
                              articleModel.source.name,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: articleModel.source.name.length >=23? 11 : 13
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}


class Article2 extends StatelessWidget{

  final ArticleModel article;

  Article2({@required this.article});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.5;
    return GestureDetector(
      onTap:(){
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ArticleDetails(article: article),
            )
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                height: height * .7,
                width: double.infinity,
                imageUrl: article.urlToImage,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context,url,downloadProgress) =>
                Image.asset('assets/images/noimage.png'),
                errorWidget: (context,url,error) =>
                Image.asset('assets/images/noimage.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title,
                textAlign:  Helper.isArabic(article.title)? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  fontSize: article.title.length >= 90? 15 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(
                  label: Text(
                    article.source.name,
                  ),
                  backgroundColor: Colors.white,
                  avatar: Icon(
                    Icons.remove_red_eye_rounded,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
                Chip(
                  label: Text(
                    Helper.date(article.publishedAt),
                  ),
                  backgroundColor: Colors.white,
                  avatar: Icon(
                    Icons.schedule,
                    size: 15,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
