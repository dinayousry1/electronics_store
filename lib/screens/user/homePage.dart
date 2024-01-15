import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_store/constant.dart';
import 'package:electronics_store/functions.dart';
import 'package:electronics_store/models/product.dart';
import 'package:electronics_store/screens/login.dart';
import 'package:electronics_store/screens/user/Cart.dart';
import 'package:electronics_store/screens/user/productDescription.dart';
import 'package:electronics_store/services/auth.dart';
import 'package:electronics_store/services/store.dart';
import 'package:electronics_store/widgets/ProductsView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  late User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: Colors.blue.shade200,
              onTap: (value) async {
                if (value == 1) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Navigator.popAndPushNamed(context, Login.id);
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Home', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Sign Out', icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.blue.shade200,
              bottom: TabBar(
                onTap: (value) {
                  setState(() {});
                  _tabBarIndex = value;
                },
                tabs: <Widget>[
                  Text(
                    'phones',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'laptops',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'headsets',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'watchs',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                phoneView(),
                ProductView(kLaptops, _products),
                ProductView(kHeadsets, _products),
                ProductView(kWatchs, _products),
              ],
            ),
          ),
        ),
        Material(
          color: Colors.blue.shade200,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              color: Colors.blue.shade200,
              height: MediaQuery.of(context).size.height * .08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Electronics'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Cart.id);
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getCurrenUser();
  }

  getCurrenUser() async {
    _loggedUser = await _auth.getUser();
  }

  Widget phoneView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data;
            products.add(Product(
                pId: doc.id,
                pPrice: data()[kProductPrice],
                pName: data()[kProductName],
                pDescription: data()[kProductDescription],
                pLocation: data()[kProductLocation],
                pCategory: data()[kProductCategory]));
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(kPhones, _products);
          Size size = MediaQuery.of(context).size;
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
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                        width: size.width - 200,
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
                                  horizontal:
                                      kDefaultPadding * 1.5, // 30 px padding
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
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }
}
