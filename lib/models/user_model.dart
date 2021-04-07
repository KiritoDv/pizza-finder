class UserModel {

  final String id;  
  final String email;
  final String birthday;
  final String firstName;
  final String lastName;
  final String gender;
  final String username;
  final String avatar;
  final String token;

  UserModel({this.id, this.firstName, this.email, this.lastName, this.gender, this.username, this.avatar, this.birthday, this.token});

  factory UserModel.fromJson(Map<dynamic, dynamic> obj) => UserModel(
    id:        obj["user"]["id"],
    email:     obj["user"]["email"],
    birthday:  obj["user"]["birthday"],
    firstName: obj["user"]["firstName"],
    lastName:  obj["user"]["lastName"],
    gender:    obj["user"]["gender"],
    username:  obj["user"]["username"],
    avatar:    obj["user"]["avatar"],
    token:     obj["session"]["data"]
  );

  Map<dynamic, dynamic> toJson() => {
    "user": {
      "id":        this.id,
      "email":     this.email,
      "birthday":  this.birthday,
      "firstName": this.firstName,
      "lastName":  this.lastName,
      "gender":    this.gender,
      "username":  this.username,
      "avatar":    this.avatar
    },
    "session": {
      "data":      this.token
    }
  };
}