import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/adapter/category_item_view.dart';
import 'package:vegetableshopping/com/shopping/activated/adapter/item_view.dart';
import 'package:vegetableshopping/com/shopping/models/data_model.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_json.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> _productList = [];
  List<CategoryModel> _categoryList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var data = await CustomJson.loadProductJson();
    var catData = await CustomJson.loadCatJson();
    setState(() {
      _productList = data;
      _categoryList = catData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _getUI(),
        ),
      ),
    );
  }

  _getUI() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Categories",
                textAlign: TextAlign.start,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: CustomColors.titleDarkColor,
                  fontSize: 15,
                  fontFamily: "OpenSansBold",
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: _onCategorySeeAll,
                child: Text(
                  "See All",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.colorPrimary,
                    fontSize: 13,
                    fontFamily: "OpenSansBold",
                    fontWeight: FontWeight.normal,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _getCategory(),
        const SizedBox(height: 10),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Popular Deals",
                textAlign: TextAlign.start,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: CustomColors.titleDarkColor,
                  fontSize: 15,
                  fontFamily: "OpenSansBold",
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: _onCategorySeeAll,
                child: Text(
                  "See All",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.colorPrimary,
                    fontSize: 13,
                    fontFamily: "OpenSansBold",
                    fontWeight: FontWeight.normal,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _getPopularDeals(),
        const SizedBox(height: 10),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Best Sellers",
                textAlign: TextAlign.start,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: CustomColors.titleDarkColor,
                  fontSize: 15,
                  fontFamily: "OpenSansBold",
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: _onBestSellerSeeAll,
                child: Text(
                  "See All",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.colorPrimary,
                    fontSize: 13,
                    fontFamily: "OpenSansBold",
                    fontWeight: FontWeight.normal,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _getBestSeller(),
      ],
    );
  }

  Widget _getCategory() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return CategoryItemView(index: index, category: _categoryList[index]);
        },
      ),
    );
  }

  Widget _getPopularDeals() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return CategoryItemView(index: index, category: _categoryList[index]);
        },
      ),
    );
  }

  Widget _getBestSeller() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: _productList.length,
      itemBuilder: (context, index) {
        return ItemView(index: index, productModel: _productList[index]);
      },
    );
  }

  void _onCategorySeeAll() {}

  void _onBestSellerSeeAll() {}
}
