import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_store/screens/admin/editProduct.dart';
import 'package:flutter/material.dart';

import 'package:electronics_store/constant.dart';
import 'package:electronics_store/screens/admin/ordersScreen.dart';
import 'package:electronics_store/screens/admin/addProduct.dart';
import 'package:electronics_store/screens/admin/manageProduct.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          Text(
            "Admin Home",
            style: TextStyle(
                fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('Edit Product'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text('View orders'),
          )
        ],
      ),
    );
  }
}
