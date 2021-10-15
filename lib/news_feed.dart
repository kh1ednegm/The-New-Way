import 'package:flutter/material.dart';
import 'package:news_app/article.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/model.dart';
import 'package:news_app/service.dart';



Future<List<ArticleModel>> articles;
String searchText = 'م';

class NewsFeed extends StatefulWidget{


  @override
  State createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed>{

  // key  e92425a72b4047e5b6af276431e0da99



  TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    articles =  NetworkHelper.getArticles(category);
  }


  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  int _selected=0;
  var x = [
    'All',
    'Sports',
    'Entertainment',
    'Health',
    'Business',
    'Science',
    'Technology',
  ];

  List<Widget> _buildChoiceChip(){
    List<Widget> chips = new List();
    for(int i =0; i< x.length;i++){
      ChoiceChip chip = ChoiceChip(
        label: Text(
            x[i],
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        selected: _selected == i,
        selectedColor: Colors.grey[400],
        backgroundColor: Colors.grey[200],
        onSelected: (value){
          setState(() {
            category = x[i];
            articles = NetworkHelper.getArticles(category.toLowerCase());
            if(value){
              _selected = i;
            }
          });
        },
      );
      chips.add(chip);
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30,bottom: 8,left: 20,),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'The New Way',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Discover News from all over the world',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200
              ),

            ),
            Container(
              margin: const EdgeInsets.only(right: 20,top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200],
              ),
              child: TextField(
                textAlign: Helper.isArabic(search.text)? TextAlign.right : TextAlign.left,
                controller: search,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(
                      Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                    ),
                    onPressed: (){
                      setState(() {
                        search.clear();
                      });
                    },
                  ),
                ),
                style: kSearchBarStyle,
                onSubmitted: (value) async{
                  searchText = value;
                  articles = NetworkHelper.getArticlesBySearch(searchText);
                  setState(() {

                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              children: _buildChoiceChip(),
            ),

             Divider(
              color: Colors.black,
               endIndent: 15,
               thickness: 1,
            ),
            FutureBuilder<List<ArticleModel>>(
              future: articles,
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 200,),
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Loading',
                              style: TextStyle(
                                fontSize: 23,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                else if (snapshot.hasError || snapshot.data == null || snapshot.data.length ==0){
                  return Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 200,),
                          Icon(
                            Icons.error_outline_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            'Something went wrong'
                          ),
                          TextButton(
                            child: Text(
                              'Try again',
                              style: TextStyle(
                                fontSize: 23,
                              ),
                            ),
                            onPressed: () async{
                              if(search.text == ''){
                                articles =  NetworkHelper.getArticles(category);
                              }
                              else
                                articles = NetworkHelper.getArticlesBySearch(search.text);
                              setState(() {

                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else
                  return Flexible(
                    child: ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: Article(
                              articleModel: snapshot.data[index]
                          ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}



