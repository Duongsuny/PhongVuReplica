import 'package:flutter/material.dart';

class ChipGroup extends StatelessWidget {
  final List options;
  final int selectedIndex;
  final Function(int) onSelected;
  const ChipGroup({super.key, required this.options, required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        children: options.map((option) {
          int index = options.indexOf(option);
          return GestureDetector(
            child: FilterChip(
              selected: index == selectedIndex,
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      color: index == selectedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300)),
              selectedColor: Colors.white,
              label: Text(options[index]["label"]),
              labelStyle: TextStyle(
                  fontSize: 15,
                  color: index == selectedIndex
                      ? Theme.of(context).primaryColor
                      : Colors.black),
              onSelected: (bool isSelected) {
                if (isSelected) {
                  onSelected(index);
                } else {
                  onSelected(0);
                }
              },
            ),
          );
        }).toList());
  }
}
