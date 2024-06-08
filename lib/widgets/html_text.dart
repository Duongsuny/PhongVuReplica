import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:phongvu_copycat/utils/html_preview.dart';

class HTMLText extends StatelessWidget {
  final String HTMLString;
  const HTMLText({super.key, required this.HTMLString});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            "Chi tiết sản phẩm",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        const SizedBox(height: 15),
        SizedBox(height: 1, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade300)),),
        const SizedBox(height: 15),
        ExpandablePanel(
          collapsed: Column(
            children: [
              HtmlWidget(HTMLPreview().preview(HTMLString, 383)),
              ExpandableButton(
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const Text(
                    "Xem thêm nội dung",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
          expanded: Column(
            children: [
              HtmlWidget(HTMLString),
              ExpandableButton(
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const Text(
                    "Thu gọn nội dung",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
          //body: HtmlWidget(product.description)
        ),
      ],
    );
  }
}
