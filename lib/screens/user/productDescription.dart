import 'package:electronics_store/models/product.dart';
import 'package:electronics_store/provider/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  static String id = 'ProductDescription';
  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        backgroundColor: Colors.blue.shade200,
        appBar: detailsAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0 * 1.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage(product.pLocation),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0 / 2),
                    child: Text(product.pName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway')),
                  ),
                  Text(
                    'price: \$${product.pPrice}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.shade500,
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0 / 2),
              padding: EdgeInsets.symmetric(
                horizontal: 20.0 * 1.5,
                vertical: 20.0 / 2,
              ),
              child: Text(
                product.pDescription,
                style: TextStyle(color: Colors.white, fontSize: 19.0),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: Colors.blue.shade500,
                    child: GestureDetector(
                      onTap: add,
                      child: SizedBox(
                        child: Icon(Icons.add),
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ),
                Text(
                  _quantity.toString(),
                  style: TextStyle(fontSize: 40),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.blue.shade500,
                    child: GestureDetector(
                      onTap: subtract,
                      child: SizedBox(
                        child: Icon(Icons.remove),
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: ButtonTheme(
                height: MediaQuery.of(context).size.height * .12,
                minWidth: MediaQuery.of(context).size.width,
                buttonColor: Colors.blue.shade500,
                child: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      addToCart(context, product);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade500),
                    child: Text(
                      "add to card".toUpperCase(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: 20.0),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.blue.shade500,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('you\'ve added this item before'),
      ));
    } else {
      cartItem.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }
  }
}
