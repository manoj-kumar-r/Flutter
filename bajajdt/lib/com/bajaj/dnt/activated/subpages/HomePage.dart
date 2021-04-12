import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/database/Db.dart';
import 'package:bajajdt/com/bajaj/dnt/models/ApiModel.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  var _brandItems = List<Brand>();
  var _dataBase = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    var data = await _dataBase.getBrandList(
        0, "", pref.getString(PreferenceHolders.userId));

    if (_selectedBrand != null) {
      for (int index = 0; index < data.length; index++) {
        if (data[index].brandid == _selectedBrand.brandid) {
          data[index].clicked = true;
        } else {
          data[index].clicked = false;
        }
      }
    }
    setState(() {
      _brandItems = data;
      if (_selectedBrand != null) {
        _setSelectedVariants();
      }
    });
  }

  var _selectedBrand;
  var _selectedBrandItems = List<Brand>();

  @override
  Widget build(BuildContext context) {
    return  ListView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "SELECT BRAND",
            textAlign: TextAlign.start,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
            textDirection: TextDirection.ltr,
          ),
          color: CustomColors.blackTranslucent,
        ),
        SizedBox(height: 5),
        Container(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: ScrollPhysics(),
            children: _brandItems
                .map(
                  (e) => GestureDetector(
                onTap: () {
                  _brandSelected(e);
                },
                child: _getGridViewItem(e),
              ),
            )
                .toList(),
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "SELECT MODEL",
            textAlign: TextAlign.start,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
            textDirection: TextDirection.ltr,
          ),
          color: CustomColors.blackTranslucent,
        ),
        Container(
          child: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _selectedBrandItems.length,
            itemBuilder: (context, index) {
              return _getSelectedBrandItem(this._selectedBrandItems[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _getGridViewItem(Brand brand) {
    AssetImage selectedImage;
    if (brand.vehicletype != null) {
      if (brand.clicked != null && brand.clicked) {
        if (brand.vehicletype == "3W") {
          selectedImage = AssetImage("assets/images/ic_auto_tick.png");
        } else if (brand.vehicletype == "4W") {
          selectedImage = AssetImage("assets/images/ic_four_wheel_tick.png");
        } else {
          selectedImage = AssetImage("assets/images/ic_tick.png");
        }
      } else {
        if (brand.vehicletype == "3W") {
          selectedImage = AssetImage("assets/images/ic_3_whel_white.png");
        } else if (brand.vehicletype == "4W") {
          selectedImage = AssetImage("assets/images/ic_four_wheel.png");
        } else {
          selectedImage = AssetImage("assets/images/white_bike.png");
        }
      }
    }
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                width: 45.0,
                height: 45.0,
                image: selectedImage,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            brand.brand,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }

  Widget _getSelectedBrandItem(Brand brand) {
    AssetImage selectedImage;
    if (brand.favSelected) {
      selectedImage = AssetImage("assets/images/ic_star_gold.png");
    } else {
      selectedImage = AssetImage("assets/images/ic_star_black.png");
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _variantSelected(brand);
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        brand.variant,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                _favSelected(brand);
              },
              child: Image(
                width: 30,
                height: 30,
                image: selectedImage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _brandSelected(Brand selectedBrand) {
    setState(() {
      for (int index = 0; index < _brandItems.length; index++) {
        if (_brandItems[index].brandid == selectedBrand.brandid) {
          if (_brandItems[index].clicked != null &&
              _brandItems[index].clicked) {
            _selectedBrand = null;
            _brandItems[index].clicked = false;
          } else {
            _selectedBrand = selectedBrand;
            _brandItems[index].clicked = true;
          }
        } else {
          _brandItems[index].clicked = false;
        }
      }
      _setSelectedVariants();
    });
  }

  Future<void> _setSelectedVariants() async {
    var data;
    if (_selectedBrand != null) {
      var pref = await SharedPreferences.getInstance();
      data = await _dataBase.getBrandList(
          1, _selectedBrand.brandid, pref.getString(PreferenceHolders.userId));
    } else {
      data = List<Brand>();
    }
    print(data.length);
    for (int index = 0; index < data.length; index++) {
      data[index].favSelected = await _dataBase.getFavCount(data[index]) > 0;
    }

    setState(() {
      _selectedBrandItems = data;
    });
  }

  void _variantSelected(Brand brand) {}

  Future<void> _favSelected(Brand brand) async {
    var message = "";
    if (await _dataBase.getFavCount(brand) > 0) {
      await _dataBase.deleteFav(brand);
      message = "Fav removed";
    } else {
      var pref = await SharedPreferences.getInstance();
      await _dataBase.insertFavBrand(
          brand, pref.getString(PreferenceHolders.userId));
      message = "Fav Added";
    }
    CustomUIElements.showSnackBar(context, message);
    _setSelectedVariants();
  }
}
