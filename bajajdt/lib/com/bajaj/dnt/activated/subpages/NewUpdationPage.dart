import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/database/Db.dart';
import 'package:bajajdt/com/bajaj/dnt/models/ApiModel.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NewUpdatePage extends StatefulWidget {
  @override
  _NewUpdatePageState createState() => _NewUpdatePageState();
}

class _NewUpdatePageState extends State<NewUpdatePage> {
  var _favItems = List<Brand>();
  var _dataBase = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    var data =
    await _dataBase.getFavList(pref.getString(PreferenceHolders.userId));
    print(data.length);
    for (int index = 0; index < data.length; index++) {
      data[index].favSelected = await _dataBase.getFavCount(data[index]) > 0;
    }
    setState(() {
      _favItems = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _favItems.length,
        itemBuilder: (context, index) {
          return _getSelectedBrandItem(this._favItems[index]);
        },
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

  void _variantSelected(Brand brand) {}

  Future<void> _favSelected(Brand brand) async {
    await _dataBase.deleteFav(brand);
    CustomUIElements.showSnackBar(context, "Fav removed");
    getData();
  }
}

