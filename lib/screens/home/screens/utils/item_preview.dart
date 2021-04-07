import 'package:flutter/material.dart';
import 'package:pizza_finder/models/pizza_model.dart';
import 'package:pizza_finder/screens/home/screens/widgets/price_range.dart';
import 'package:pizza_finder/widgets/network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemManager {

  static showItemPreview( context, fb, PizzaModel model ){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context, 
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Stack(
                        children: [
                          FutureBuilder(
                            future: ImageUtils.fetchImage(fb, model.cover),
                            builder: (context, snap) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  width: snap.hasData ? MediaQuery.of(context).size.width : 53,
                                  height: snap.hasData ? MediaQuery.of(context).size.height : 32,
                                  fit: BoxFit.cover,
                                  image: snap.hasData ? snap.data : fb,
                                ),
                              );
                            }
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(model.score.round(), (index) => Icon(Icons.star, size: 12)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 150
                                  ),
                                  child: Container (                                
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                    color: Colors.black,
                                    child: Text(model.name, maxLines: 2, style: TextStyle(fontSize: 12, color: Colors.white)),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Container(
                                  padding: EdgeInsets.only(bottom: 2, left: 8),
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.black
                                  ),
                                  child: PriceRange(length: model.price),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.black,
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                child: SingleChildScrollView(child: Text(model.description, style: TextStyle(fontSize: 12, color: Colors.white))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if( model.social.twitter != null )
                      InkWell(
                        onTap: () async => await launch( model.social.twitter ),
                        child: Container(
                          width: 32,
                          height: 32,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Image(
                            image: AssetImage("assets/social/twitter.png"),
                          ),
                        ),
                      ),
                      if( model.social.instagram != null )
                      InkWell(
                        onTap: () async => await launch( model.social.instagram ),
                        child: Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.only(left: 10),
                          child: Image(
                            image: AssetImage("assets/social/instagram.png"),
                          ),
                        ),
                      ),
                      if( model.social.tiktok != null )
                      InkWell(
                        onTap: () async => await launch( model.social.tiktok ),
                        child: Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.only(left: 10),
                          child: Image(
                            image: AssetImage("assets/social/tiktok.png"),
                          ),
                        ),
                      ),
                      if( model.social.facebook != null )
                      InkWell(
                        onTap: () async => await launch( model.social.facebook ),
                        child: Container(
                          width: 32,
                          height: 32,
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF1778F2),
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Image(
                            image: AssetImage("assets/social/facebook.png"),
                          ),
                        )
                      ),
                      if( model.social.website != null )
                      InkWell(
                        onTap: () async => await launch( model.social.website ),
                        child: Container(
                          width: 32,
                          height: 32,
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Image(
                            image: AssetImage("assets/social/website.png"),
                          ),
                        )
                      ),
                      Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () async => await launch( "https://www.google.com/maps/search/${model.address}" ),
                        child: Container(
                          width: 32,
                          height: 32,
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Icon(Icons.map_outlined),
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}