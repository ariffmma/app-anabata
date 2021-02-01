import 'package:flutter/material.dart';
import 'package:blogapp/chat/screens/home/child/otes/components/title_text.dart';
import 'package:blogapp/chat/screens/home/child/otes/models/Product.dart';
import 'package:blogapp/chat/screens/home/child/hit.dart';

import 'constants.dart';
import 'size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  final Product product;
  final Function press;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
      child: AspectRatio(
        aspectRatio: 0.693,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.5,
              child: Hero(
                tag: product.id,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/spinner.gif",
                  image: product.image,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize),
              child: TitleText(title: product.title),
            ),
            SizedBox(height: 40),
            Positioned(
              right: 20,
              bottom: 170,
              child: TextButton(
                  child: Text("${product.category}"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HIT()),
                    );
                  }),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
