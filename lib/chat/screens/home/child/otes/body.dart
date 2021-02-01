import 'package:flutter/material.dart';

import 'package:blogapp/chat/screens/home/child/otes/title_text.dart';
import 'package:blogapp/chat/screens/home/child/otes/service/fetchCategories.dart';
import 'package:blogapp/chat/screens/home/child/otes/service/fetchProducts.dart';
import 'package:blogapp/chat/screens/home/child/otes/size_config.dart';

import 'categories.dart';
import 'recommond_products.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // It enables scrolling
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: fetchProducts(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? RecommandProducts(products: snapshot.data)
                    : Center(child: Image.asset('assets/ripple.gif'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
