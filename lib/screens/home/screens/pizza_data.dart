import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:pizza_finder/local/db.dart';
import 'package:pizza_finder/models/pizza_model.dart';
import 'package:pizza_finder/screens/home/screens/utils/item_preview.dart';
import 'package:pizza_finder/screens/home/screens/widgets/price_range.dart';
import 'package:pizza_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:pizza_finder/utils/FutureUtils.dart';
import 'package:pizza_finder/widgets/network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PizzaDataView extends StatefulWidget {
  @override
  _PizzaDataState createState() => _PizzaDataState();
}

class _PizzaDataState extends State<PizzaDataView> {
  
  final _refreshKey = GlobalKey<_PizzaDataState>();
  var fb = AssetImage("assets/icons/main-icon.png");
  ScrollController controller;
  List items = [];
  var lastIndex;
  var endOfList = false;

  @override
  void initState() {
    this.fetchData();   
    this.controller = ScrollController();
    this.controller.addListener(this.handleScroll);
    super.initState();
  }

  fetchData() async {
    if(this.endOfList) return;

    var res = await Services.searchPizza(
      token: LocalData.user.token,        
      query: lastIndex != null ? { "cursor": lastIndex } : {}
    );
    if(res.statusCode == 200) {
      var data = json.decode(res.body)["data"];
      setState(() {
        if(data.isEmpty) {
          this.endOfList = true;
          return;
        }
        var newIndex = data[data.length - 1]["id"];        
        items.addAll(data);
        lastIndex = newIndex;
      });
    }
  }

  handleScroll() async {
    if(this.endOfList) return;

    if(this.controller.position.pixels == this.controller.position.maxScrollExtent){      
      FutureUtils.showLoading(context);
      await this.fetchData();
      Navigator.pop(context);
    }
  }

  Widget pizzaItem(item){
    final Size size = MediaQuery.of(context).size;    
    return InkWell(
      onTap: () => ItemManager.showItemPreview(context, fb, PizzaModel.fromJson(item)),
      child: Container(
        margin: EdgeInsets.all(5),
        width: size.width / 2 - 20,
        height: size.width / 2 - 20,
        child: Stack(
          children: [
            FutureBuilder(
              future: ImageUtils.fetchImage(fb, item["cover"]),
              builder: (context, snap) {
                return Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      width: snap.hasData ? MediaQuery.of(context).size.width : 32,
                      height: snap.hasData ? MediaQuery.of(context).size.height : 32,
                      fit: BoxFit.cover,
                      image: snap.hasData ? snap.data : fb,
                    ),
                  ),
                );
              }
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                      child: FittedBox(
                        child: Text(item["name"], textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w900))
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(item["score"].round(), (index) => Icon(Icons.star, size: 12)),
                      ),
                    )
                  ],
                )
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: InkWell(
                    child: Icon( LocalData.db.itemExists(item["id"]) ? Icons.star : Icons.star_border, size: 13),
                    onTap: () async {
                      print(LocalData.db.itemExists(item["id"]));
                      if(LocalData.db.itemExists(item["id"]))
                        await LocalData.db.removeItem(item["id"]);
                      else 
                        await LocalData.db.saveItem(PizzaModel.fromJson(item));
                      setState(() {});
                    },
                  ),
                )
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: PriceRange(length: item["priceRange"]),
                )
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffececec), width: 1.5),
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              key: this._refreshKey,
              onRefresh: () async {
                setState((){
                  this.items.clear();
                  this.lastIndex = null;
                  this.fetchData();
                });
              },
              child: SingleChildScrollView(
                controller: this.controller,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: this.items.isEmpty ? List.generate(8, (index) => null).map<Widget>((e) => Container(
                      margin: EdgeInsets.all(5),
                      width: size.width / 2 - 20,
                      height: size.width / 2 - 20,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffececec), width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.25)
                      ),
                    )).toList() : this.items.map<Widget>(this.pizzaItem).toList()
                )
              ),
            ),
          ),
          SizedBox(height: 90)
        ],
      ),
    );
  }
}