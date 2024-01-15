import 'package:electronics_store/constant.dart';
import 'package:electronics_store/functions.dart';
import 'package:electronics_store/models/product.dart';
import 'package:electronics_store/screens/user/productDescription.dart';
import 'package:flutter/material.dart';

Widget ProductView(String pCategory, List<Product> allProducts) {
  List<Product> products;
  products = getProductByCategory(pCategory, allProducts);
  return ListView.builder(
    itemBuilder: (context, index) => Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 190.0,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDescription.id,
              arguments: products[index]);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 190.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 25,
                      color: Colors.black12),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160.0,
                width: 200.0,
                child: Image.asset(
                  products[index].pLocation,
                  fit: BoxFit.fill,
                  height: 60,
                  width: 60,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: SizedBox(
                height: 170.0,
                // Because oure image is 200 width, then: width - 200
                width: MediaQuery.of(context).size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        products[index].pName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        products[index].pDescription,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 px padding
                          vertical: kDefaultPadding / 5, // 5 px padding
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text('\$ ${products[index].pPrice}'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    itemCount: products.length,
  );
}
