import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/models/data_model.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class CategoryItemView extends StatefulWidget {
  final int index;
  final CategoryModel category;

  const CategoryItemView(
      {Key? key, required this.index, required this.category})
      : super(key: key);

  @override
  _CategoryItemViewState createState() =>
      _CategoryItemViewState(index: index, category: category);
}

class _CategoryItemViewState extends State<CategoryItemView> {
  final int index;
  final CategoryModel category;

  _CategoryItemViewState({required this.index, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomColors.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              category.catName,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: CustomColors.titleDarkColor,
                  fontSize: 10,
                  fontFamily: "OpenSansBold",
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold),
              textDirection: TextDirection.ltr,
            ),
          ),
          Image.network(
            category.catUrl,
            errorBuilder: (context, exception, stackTrace) {
              return const Image(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/ic_no_image.png"),
              );
            },
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
