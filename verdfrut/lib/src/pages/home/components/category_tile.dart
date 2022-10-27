import 'package:flutter/material.dart';
import 'package:greenfrut/src/config/custom_colors.dart';

class CategoriesTile extends StatelessWidget {
  const CategoriesTile({
    super.key,
    required this.category,
    required this.isSelect,
    required this.onPressed,
  });

  final String category;
  final bool isSelect;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelect
                    ? CustomColors.customContrastColor
                    : Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelect
                        ? Colors.white
                        : CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                    fontSize: isSelect ? 16 : 14,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 30,
            height: 2,
            color: isSelect
                ? CustomColors.customContrastColor
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
