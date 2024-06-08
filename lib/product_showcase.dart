import 'package:flutter/material.dart';
import 'package:phongvu_copycat/models/product.dart';
import 'package:phongvu_copycat/services/api_service.dart';
import 'package:phongvu_copycat/utils/price.dart';
import 'package:phongvu_copycat/widgets/attributes_table.dart';
import 'package:phongvu_copycat/widgets/carousel.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:phongvu_copycat/widgets/filter_chips_group.dart';
import 'package:phongvu_copycat/widgets/html_text.dart';

class ProductShowcase extends StatefulWidget {
  const ProductShowcase({super.key});

  @override
  State<ProductShowcase> createState() => _ProductShowcaseState();
}

class _ProductShowcaseState extends State<ProductShowcase> {
  final apiService = ApiService(
      "https://discovery.tekoapis.com/api/v1/product?productld=535038&sku=230900684&location=&terminalCode=phongvu");
  int colorIndex = 0;
  int storageIndex = 0;

  void onColorSelect(int index) {
    setState(() {
      colorIndex = index;
    });
  }

  void onStorageSelect(int index) {
    setState(() {
      storageIndex = index;
    });
  }

  SizedBox sectionBreak = SizedBox(
      height: 8,
      width: double.infinity,
      child:
          DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade100)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //leading back button
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),

          //cart and three-dots actions
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined, size: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder<Product>(
            future: apiService.fetchProduct(),
            builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final Product product = snapshot.data!;
                return Center(
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Product images carousel
                          ProductCarousel(imageURLs: product.imageURLs()),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'MÀU SẮC: ${product.colors[colorIndex]["label"]}'
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.blueGrey, fontSize: 15),
                                    ),
                                    ChipGroup(
                                        options: product.colors,
                                        selectedIndex: colorIndex,
                                        onSelected: onColorSelect),
                                    const SizedBox(height: 20),
                                    //storages selection
                                    Text(
                                      'DUNG LƯỢNG (ROM): ${product.storages[storageIndex]["label"]}'
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.blueGrey, fontSize: 15),
                                    ),
                                    ChipGroup(
                                        options: product.storages,
                                        selectedIndex: storageIndex,
                                        onSelected: onStorageSelect),
                                    const SizedBox(height: 20),
                                    //Product name and prices
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    //Product price
                                    Text(
                                      "${PriceUtils.formatPrice(product.prices[0]["latestPrice"])}đ̲",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "${PriceUtils.formatPrice(product.prices[0]["supplierRetailPrice"])}đ̲",
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "-${product.prices[0]["discountPercent"]}%",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    HtmlWidget(product.shortDescription),
                                    const SizedBox(height: 15),
                                    Text("Thương hiệu ${product.brand} | SKU: ${product.colors[colorIndex]["sku"]}", style: TextStyle(color: Colors.grey),),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              sectionBreak,
                              //Product attribute table
                              AttributesTable(
                                attributes: product.attributes,
                              ),

                              sectionBreak,
                              //HTMl text
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: HTMLText(HTMLString: product.description),
                              ),

                              sectionBreak,
                              const SizedBox(height: 50)
                            ],
                          )
                        ],
                      ),
                    ),

                    // Fixed position button
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(color: Colors.grey.shade300))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "Liên hệ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ]),
                );
              } else {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
            }),
        //Messenger Button
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            child: Image.asset("lib/assets/messenger.png"),
          ),
        ));
  }
}
