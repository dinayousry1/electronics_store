import 'package:electronics_store/models/product.dart';

List<Product> getProductByCategory(String kPhones, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == kPhones) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }

  return products;
}
