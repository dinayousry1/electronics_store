import 'package:electronics_store/constant.dart';
import 'package:electronics_store/models/product.dart';
import 'package:electronics_store/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:electronics_store/services/store.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  late String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  },
                  icon: Icons.airplay_sharp,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _price = value;
                  },
                  hint: 'Product Price',
                  icon: Icons.paid_sharp,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _description = value;
                  },
                  hint: 'Product Description',
                  icon: Icons.description_rounded,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _category = value;
                  },
                  hint: 'Product Category',
                  icon: Icons.category_sharp,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _imageLocation = value;
                  },
                  hint: 'Product Location',
                  icon: Icons.image,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState?.save();

                      _store.editProduct(
                          ({
                            kProductName: _name,
                            kProductLocation: _imageLocation,
                            kProductCategory: _category,
                            kProductDescription: _description,
                            kProductPrice: _price
                          }),
                          product.pId);
                    }
                  },
                  child: Text('Edit Product'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
