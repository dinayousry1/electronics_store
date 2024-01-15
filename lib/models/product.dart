class Product {
  String pName;
  String pPrice;
  String pLocation;
  String pDescription;
  String pCategory;
  String? pId;
  int? pQuantity;
  Product(
      {required this.pName,
      required this.pCategory,
      required this.pDescription,
      required this.pLocation,
      required this.pPrice,
      this.pId,
      this.pQuantity});
}
