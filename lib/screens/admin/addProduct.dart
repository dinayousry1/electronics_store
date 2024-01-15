import 'package:electronics_store/models/product.dart';
import 'package:electronics_store/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:electronics_store/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  late String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
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
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                hint: 'Product Price',
                onClick: (value) {
                  _price = value;
                },
                icon: Icons.paid_sharp,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Product Description',
                onClick: (value) {
                  _description = value;
                },
                icon: Icons.description_rounded,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Product Category',
                onClick: (value) {
                  _category = value;
                },
                icon: Icons.category_sharp,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Product Location',
                onClick: (value) {
                  _imageLocation = value;
                },
                icon: Icons.image,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState?.save();

                      _store.addProduct(Product(
                        pName: _name,
                        pPrice: _price,
                        pDescription: _description,
                        pLocation: _imageLocation,
                        pCategory: _category,
                      ));
                    }
                  },
                  child: Text(
                    'Add product',
                    style: TextStyle(color: Colors.white),
                  ))
            ]),
          ],
        ),
      ),
    );
  }
}
