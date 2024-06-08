class Product {
  final List images;
  final String brand;
  final String name;
  final List colors;
  final List storages;
  final List prices;
  final String description;
  final String shortDescription;
  final List attributes;

  Product(

      {
      required this.name, 
      required this.brand,
      required this.images,
      required this.colors,
      required this.storages,
      required this.prices,
      required this.description,
      required this.attributes,
      required this.shortDescription
      }
      //required this.options}
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      colors: json['result']["product"]["productOptions"]["rows"][0]["options"],
      storages: json['result']["product"]["productOptions"]["rows"][1]["options"],
      name: json['result']["product"]["productInfo"]["name"],
      brand: json['result']["product"]["productInfo"]["brand"]["name"],
      images: json['result']["product"]["productDetail"]['images'],
      prices: json['result']["product"]["prices"],
      description: json['result']["product"]["productDetail"]["description"],
      shortDescription: json['result']["product"]["productDetail"]["shortDescription"],
      attributes: json['result']["product"]["productDetail"]["attributeGroups"]
    );
  }

//Get all the color options from the Json file

//Get all the image urls from the Json file
  List<String> imageURLs() {
    List<String> urls = [];
    for(Map image in images) {
      urls.add(image["url"]);
    }
    return urls;
  }
}
