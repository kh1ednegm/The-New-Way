

import 'package:flutter/cupertino.dart';


String category = 'All'.toLowerCase();
class Helper{


  static String date(String date) {
    var temp = date.substring(8, 10) +
        '-' +
        date.substring(5, 7) +
        '-' +
        date.substring(0, 4);
    return temp;
  }

  static bool isArabic(String s) => RegExp('[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufbc1]|[\ufbd3-\ufd3f]|[\ufd50-\ufd8f]|[\ufd92-\ufdc7]|[\ufe70-\ufefc]|[\uFDF0-\uFDFD]')
      .hasMatch(s);
}

TextStyle kTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight:FontWeight.bold,

);

TextStyle kSearchBarStyle = TextStyle(
  fontSize: 20,
);