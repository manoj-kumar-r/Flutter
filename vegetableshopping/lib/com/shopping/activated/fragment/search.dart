import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/adapter/item_view.dart';
import 'package:vegetableshopping/com/shopping/models/data_model.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_json.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  List<ProductModel> _productList = [];
  List<SearchModel> _searchList = [];

  var _searchFull = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var data = await CustomJson.loadProductJson();
    var searchData = await CustomJson.loadSearchJson();
    setState(() {
      _productList = data;
      _searchList = searchData;
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
          child: _getUi(),
        ),
      ),
    );
  }

  _getUi() {
    return Column(
      children: [
        const SizedBox(height: 10),
        _getSearch(),
        const SizedBox(height: 10),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Recent Searches",
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
                onTap: _onRecentSearchSeeAll,
                child: Text(
                  "See More",
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
        _getSearchList(),
        const SizedBox(height: 10),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Popular List",
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
                onTap: _onPopularSeeAll,
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
        _getPopularList(),
      ],
    );
  }

  _getSearch() {
    return TextField(
      autocorrect: true,
      onChanged: (value) => _searchValue(value),
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black45,
        ),
        labelStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black45,
          fontFamily: 'OpenSansBold',
        ),
        hintStyle: const TextStyle(color: Colors.black45),
        filled: true,
        fillColor: CustomColors.bgColor,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.white, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.white, width: 1),
        ),
      ),
    );
  }

  _getSearchList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: (_searchFull)
          ? _searchList.length
          : (_searchList.isNotEmpty)
              ? 3
              : 0,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                color: Colors.black45,
              ),
              const SizedBox(width: 5),
              Text(_searchList[index].name),
            ],
          ),
        );
      },
    );
  }

  _getPopularList() {
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

  _searchValue(String value) {}

  void _onRecentSearchSeeAll() {
    setState(() {
      _searchFull = !_searchFull;
    });
  }

  void _onPopularSeeAll() {}
}
