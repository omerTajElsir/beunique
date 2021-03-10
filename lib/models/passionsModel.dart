class PassionsModel {
  List<Interests> interests;
  bool premium;
  String sId;
  String name;
  String selection;
  String date;
  String slug;
  int iV;

  PassionsModel(
      {this.interests,
      this.premium,
      this.sId,
      this.name,
      this.selection,
      this.date,
      this.slug,
      this.iV});

  PassionsModel.fromJson(Map<String, dynamic> json) {
    if (json['interests'] != null) {
      interests = new List<Interests>();
      json['interests'].forEach((v) {
        interests.add(new Interests.fromJson(v));
      });
    }
    premium = json['premium'];
    sId = json['_id'];
    name = json['name'];
    selection = json['selection'];
    date = json['date'];
    slug = json['slug'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.interests != null) {
      data['interests'] = this.interests.map((v) => v.toJson()).toList();
    }
    data['premium'] = this.premium;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['selection'] = this.selection;
    data['date'] = this.date;
    data['slug'] = this.slug;
    data['__v'] = this.iV;
    return data;
  }
}

class Interests {
  String sId;
  bool isPaid;
  String name;
  String category;
  String date;
  String slug;
  int iV;
  String img;

  Interests(
      {this.sId,
      this.isPaid,
      this.name,
      this.category,
      this.date,
      this.slug,
      this.img,
      this.iV});

  Interests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isPaid = json['is_paid'];
    name = json['name'];
    category = json['category'];
    date = json['date'];
    slug = json['slug'];
    iV = json['__v'];
    img = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['is_paid'] = this.isPaid;
    data['name'] = this.name;
    data['category'] = this.category;
    data['date'] = this.date;
    data['slug'] = this.slug;
    data['__v'] = this.iV;
    data['image'] = this.img;
    return data;
  }
}
