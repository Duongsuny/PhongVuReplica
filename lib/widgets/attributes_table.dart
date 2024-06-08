import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class AttributesTable extends StatelessWidget {
  final List attributes;
  const AttributesTable({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [];
    for (int i = 0; i < attributes.length; i++) {
      if (attributes[i]["value"] == "") {
        rows.add(TableRow(children: [
          TableCell(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              attributes[i]["name"],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          )),
          const TableCell(child: SizedBox.shrink())
        ]));
      } else {
        rows.add(TableRow(
            decoration: BoxDecoration(
                color: i % 2 != 0 ? Colors.grey.shade100 : Colors.white),
            children: [
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(attributes[i]["name"]),
              )),
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(attributes[i]["value"]),
              ))
            ]));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child:  Text(
            "Chi tiết sản phẩm",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(height: 1, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade300)),),
        ExpandablePanel(
          collapsed: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(150),
                  1: FlexColumnWidth(),
                },
                children: rows.take(7).toList(),
              ),
              ExpandableButton(
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const Text(
                    "Xem thêm",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          expanded: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(150),
                  1: FlexColumnWidth(),
                },
                children: rows,
              ),
              ExpandableButton(
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const Text(
                    "Thu gọn",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
