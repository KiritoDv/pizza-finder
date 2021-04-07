import 'package:pizza_finder/local/db.dart';
import 'package:pizza_finder/screens/home/screens/pizza_data.dart';
import 'package:pizza_finder/screens/home/screens/profile_view.dart';
import 'package:pizza_finder/screens/home/screens/saved_view.dart';
import 'package:pizza_finder/widgets/colors.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  PageController _pageController;

  List views = [
    {
      'icon': Icons.home,
      'path': '/',
      'enabled': true
    },
    {
      'icon': Icons.favorite,
      'path': '/',
      'enabled': false
    },
    {
      'icon': Icons.person,
      'path': '/',
      'enabled': false
    }
  ];

  @override
  void initState() {
    this._pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold (
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          bottom: PreferredSize(
            child: Container(
              height: 0.5,
              color: Colors.grey.withOpacity(.20),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 1),
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                width: 32,
                height: 32,
                image: AssetImage("assets/icons/main-icon.png"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Pizza Finder", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
          elevation: 0,
        ),
        preferredSize: new Size.fromHeight(55)
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: size.width,
                height: size.height,
                child: PageView(
                  controller: this._pageController,
                  onPageChanged: (idx) {
                    setState(() => this._selectedIndex = idx);
                  },
                  children: [
                    PizzaDataView(),
                    SavedDataView(),
                    ProfileView()
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: size.width,
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration (
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.40),
                      offset: Offset(0, 2),
                      blurRadius: 10
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
                ),
                child: Row(
                  children: this.views.map<Widget>((view) {
                    bool selected = this.views.indexOf(view) == this._selectedIndex;
                    return Expanded(
                      child: IconButton(
                        onPressed: () => setState(() {
                          this._pageController.animateToPage(this.views.indexOf(view), duration: Duration(milliseconds: 200), curve: Curves.easeOut);
                        }),
                        icon: Icon(view['icon'], size: selected ? 30 : 22, color: selected ? PColors.red.withOpacity(0.72) : Colors.black26),
                      )
                    );
                  }).toList()
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}