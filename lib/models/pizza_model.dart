class PizzaModel {
  
  final String id;  
  final String name;
  final String cover;
  final String address;
  final String description;
  final double score;
  final int price;
  final DateTime date;
  final SocialModel social;

  PizzaModel({this.id, this.name, this.cover, this.address, this.description, this.score, this.price, this.date, this.social});

  factory PizzaModel.fromJson(Map<dynamic, dynamic> obj) => PizzaModel(
    id: obj["id"],
    name: obj["name"],
    cover: obj["cover"],
    address: obj["address"],
    description: obj["description"],
    score: obj["score"],
    price: obj["priceRange"],
    date: DateTime.parse(obj["createdAt"]),
    social: SocialModel.fromJson(obj["social"]),
  );

  Map<dynamic, dynamic> toJson() => {    
    "id":          this.id,
    "name":        this.name,
    "cover":       this.cover,
    "address":     this.address, 
    "score":       this.score,
    "priceRange":  this.price,
    "date":        this.date,
    "description": this.description,
    "social":      this.social.toJson(),
    "createdAt":   this.date.toIso8601String()
  };
}

class SocialModel {

  final String facebook;
  final String instagram;
  final String tiktok;
  final String twitter;
  final String website;

  SocialModel({ this.facebook, this.instagram, this.tiktok, this.twitter, this.website });

  factory SocialModel.fromJson(Map<dynamic, dynamic> obj) => SocialModel(
    facebook:  obj["facebook"],
    instagram: obj["instagram"],
    tiktok:    obj["tiktok"],
    twitter:   obj["twitter"],
    website:   obj["website"]
  );
  
   Map<dynamic, dynamic> toJson() => {    
    "facebook":  this.facebook,
    "instagram": this.instagram,
    "tiktok":    this.tiktok,
    "twitter":   this.twitter, 
    "website":   this.website  
  };
}