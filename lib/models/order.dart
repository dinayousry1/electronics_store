class Orders {
  String documentId;
  int totallPrice;
  String? address;
  Orders(
      {required this.totallPrice,
      required this.address,
      required this.documentId});
}
