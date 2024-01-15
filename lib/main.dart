import 'dart:io' as io;
import 'package:electronics_store/constant.dart';
import 'package:electronics_store/provider/cartItem.dart';
import 'package:electronics_store/provider/modelHud.dart';
import 'package:electronics_store/provider/adminMode.dart';
import 'package:electronics_store/screens/admin/OrdersScreen.dart';
import 'package:electronics_store/screens/admin/addProduct.dart';
import 'package:electronics_store/screens/admin/adminHome.dart';
import 'package:electronics_store/screens/admin/editProduct.dart';
import 'package:electronics_store/screens/admin/manageProduct.dart';
import 'package:electronics_store/screens/admin/orderDetails.dart';
import 'package:electronics_store/screens/login.dart';
import 'package:electronics_store/screens/signup.dart';
import 'package:electronics_store/screens/user/Cart.dart';
import 'package:electronics_store/screens/user/homePage.dart';
import 'package:electronics_store/screens/user/productDescription.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  io.Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyBompH3KqP8cB8eEf__TUrZS8xIg3zwmWk",
            appId: "1:309749513666:android:4cb6b5714bb76167a82a5b",
            messagingSenderId: "309749513666",
            projectId: "electronics-store-941a1",
          ),
        )
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Loading....'),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data?.getBool(kKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? HomePage.id : Login.id,
              routes: {
                OrderDetails.id: (context) => OrderDetails(),
                OrdersScreen.id: (context) => OrdersScreen(),
                Cart.id: (context) => Cart(),
                ProductDescription.id: (context) => ProductDescription(),
                EditProduct.id: (context) => EditProduct(),
                ManageProducts.id: (context) => ManageProducts(),
                Signup.id: (context) => Signup(),
                Login.id: (context) => Login(),
                HomePage.id: (context) => HomePage(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
              },
            ),
          );
        }
      },
    );
  }
}
