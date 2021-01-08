

class Product {
  final int id;
  final String name;
  final String sku;
  final String type;
  
  Product({
      this.id,
      this.name,
      this.sku,
      this.type,
  });


  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"] != null ? json["id"] : "",
      name: json["name"] != null ? json["name"] : "",
      sku: json["sku"] != null ? json["sku"] : "",
      type: json["type"] != null ? json["type"] : "",
  );
}