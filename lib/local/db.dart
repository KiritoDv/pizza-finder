import 'dart:convert';

import 'package:pizza_finder/models/pizza_model.dart';
import 'package:pizza_finder/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {
  LocalData._();
  static final LocalData db = LocalData._();
  Box<dynamic> userBox;
  Box<dynamic> favoriteBox;

  static UserModel _userModel;

  static UserModel get user {
    if(LocalData.db.userBox == null || !Hive.isBoxOpen("user_data") || LocalData.db.userBox.toMap()["user"] == null) return null;
    if(_userModel == null) _userModel = UserModel.fromJson(LocalData.db.userBox.toMap());
    return _userModel;
  }
  static set setUser (UserModel model) {
    _userModel = model;
  }

  initDB() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    this.userBox     = await Hive.openBox<dynamic>("user_data");        
    this.favoriteBox = await Hive.openBox<dynamic>("saves_data");
  }

  Future<UserModel> createUser(UserModel model) async {
    if(userBox == null || !await Hive.boxExists("user_data")  || !Hive.isBoxOpen("user_data")){
      userBox = await Hive.openBox<dynamic>("user_data");      
    }
    LocalData.setUser = model;
    await userBox.putAll(model.toJson());

    return user;
  }

  void updateUser(UserModel model) async {
    await userBox.putAll(model.toJson());
    LocalData.setUser = model;
  }

  void removeUser() async {
    LocalData.setUser = null;
    await userBox.clear();
    await userBox.close();
  }

  Future<PizzaModel> saveItem(PizzaModel model) async {
    if(this.favoriteBox == null || !await Hive.boxExists("saves_data")  || !Hive.isBoxOpen("saves_data")){
      this.favoriteBox = await Hive.openBox<dynamic>("saves_data");      
    }
    
    await this.favoriteBox.put(model.id, model.toJson());

    return model;
  }

  List<PizzaModel> fetchItems() {
    return this.favoriteBox.toMap().values.map<PizzaModel>((value) => PizzaModel.fromJson(value)).toList();
  }

  bool itemExists( id ) {
    return this.favoriteBox.containsKey(id);
  }

  removeItem( id ) async {
    await favoriteBox.delete(id);
  }
}