class Profile {
  Location location;
  bool isBoosted;
  bool mybreak;
  int count;
  String exp;
  bool isGlobal;
  bool isDating;
  List likes;
  List blocked;
  List<Interests> interests;
  bool isPremium;
  bool preferencePaid;
  String sId;
  String user;
  String name;
  String gender;
  int age;
  List<Photos> photos;
  List<Filters> filters;
  List<BasicInfo> basicInfo;
  List preference;
  String date;
  int iV;
  String socketId;
  String profilePicture;
  String bio;
  List<Media> media;
  String id;

  Profile(
      {this.location,
      this.isBoosted,
      this.mybreak,
      this.count,
      this.exp,
      this.isGlobal,
      this.isDating,
      this.likes,
      this.blocked,
      this.interests,
      this.isPremium,
      this.preferencePaid,
      this.sId,
      this.user,
      this.name,
      this.gender,
      this.age,
      this.photos,
      this.filters,
      this.basicInfo,
      this.preference,
      this.date,
      this.iV,
      this.socketId,
      this.profilePicture,
      this.bio,
      this.media,
      this.id});

  Profile.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    isBoosted = json['is_boosted'];
    mybreak = json['break'];
    count = json['count'];
    exp = json['exp'];
    isGlobal = json['is_global'];
    isDating = json['is_dating'];
    likes = json['likes'];
    blocked = json['blocked'];

    if (json['interests'] != null) {
      interests = new List<Interests>();
      json['interests'].forEach((v) {
        interests.add(new Interests.fromJson(v));
      });
    }
    isPremium = json['is_premium'];
    preferencePaid = json['preference_paid'];
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filters = new List<Filters>();
      json['filters'].forEach((v) {
        filters.add(new Filters.fromJson(v));
      });
    }
    if (json['basic_info'] != null) {
      basicInfo = new List<BasicInfo>();
      json['basic_info'].forEach((v) {
        basicInfo.add(new BasicInfo.fromJson(v));
      });
    }
    preference = json['preference'];

    date = json['date'];
    iV = json['__v'];
    socketId = json['socket_id'];
    profilePicture = json['profile_picture'];
    bio = json['bio'];
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['is_boosted'] = this.isBoosted;
    data['break'] = this.mybreak;
    data['count'] = this.count;
    data['exp'] = this.exp;
    data['is_global'] = this.isGlobal;
    data['is_dating'] = this.isDating;
    if (this.likes != null) {
      data['likes'] = this.likes.map((v) => v.toJson()).toList();
    }
    if (this.blocked != null) {
      data['blocked'] = this.blocked.map((v) => v.toJson()).toList();
    }
    if (this.interests != null) {
      data['interests'] = this.interests.map((v) => v.toJson()).toList();
    }
    data['is_premium'] = this.isPremium;
    data['preference_paid'] = this.preferencePaid;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['age'] = this.age;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo.map((v) => v.toJson()).toList();
    }
    if (this.preference != null) {
      data['preference'] = this.preference.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['__v'] = this.iV;
    data['socket_id'] = this.socketId;
    data['profile_picture'] = this.profilePicture;
    data['bio'] = this.bio;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Interests {
  String sId;
  bool isPaid;
  String name;
  Category category;
  String date;
  String slug;
  int iV;

  Interests(
      {this.sId,
      this.isPaid,
      this.name,
      this.category,
      this.date,
      this.slug,
      this.iV});

  Interests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isPaid = json['is_paid'];
    name = json['name'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    date = json['date'];
    slug = json['slug'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['is_paid'] = this.isPaid;
    data['name'] = this.name;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['date'] = this.date;
    data['slug'] = this.slug;
    data['__v'] = this.iV;
    return data;
  }
}

class Category {
  String sId;
  String name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Photos {
  bool isVideo;
  String sId;
  String filename;
  int index;

  Photos({this.isVideo, this.sId, this.filename, this.index});

  Photos.fromJson(Map<String, dynamic> json) {
    isVideo = json['is_video'];
    sId = json['_id'];
    filename = json['filename'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_video'] = this.isVideo;
    data['_id'] = this.sId;
    data['filename'] = this.filename;
    data['index'] = this.index;
    return data;
  }
}

class Filters {
  bool premium;
  String sId;
  Category key;
  String value;
  String type;
  String selection;
  String range;

  Filters(
      {this.premium,
      this.sId,
      this.key,
      this.value,
      this.type,
      this.selection,
      this.range});

  Filters.fromJson(Map<String, dynamic> json) {
    premium = json['premium'];
    sId = json['_id'];
    key = json['key'] != null ? new Category.fromJson(json['key']) : null;
    value = json['value'];
    type = json['type'];
    selection = json['selection'];
    range = json['range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['premium'] = this.premium;
    data['_id'] = this.sId;
    if (this.key != null) {
      data['key'] = this.key.toJson();
    }
    data['value'] = this.value;
    data['type'] = this.type;
    data['selection'] = this.selection;
    data['range'] = this.range;
    return data;
  }
}

class BasicInfo {
  bool premium;
  String sId;
  Category key;
  String value;

  BasicInfo({this.premium, this.sId, this.key, this.value});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    premium = json['premium'];
    sId = json['_id'];
    key = json['key'] != null ? new Category.fromJson(json['key']) : null;
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['premium'] = this.premium;
    data['_id'] = this.sId;
    if (this.key != null) {
      data['key'] = this.key.toJson();
    }
    data['value'] = this.value;
    return data;
  }
}

class Media {
  List<Question> question;
  bool isVideo;
  String sId;
  String user;
  String video;
  String date;
  int iV;
  String filename;
  int index;

  Media(
      {this.question,
      this.isVideo,
      this.sId,
      this.user,
      this.video,
      this.date,
      this.iV,
      this.filename,
      this.index});

  Media.fromJson(Map<String, dynamic> json) {
    if (json['question'] != null) {
      question = new List<Question>();
      json['question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
    isVideo = json['is_video'];
    sId = json['_id'];
    user = json['user'];
    video = json['video'];
    date = json['date'];
    iV = json['__v'];
    filename = json['filename'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['question'] = this.question.map((v) => v.toJson()).toList();
    }
    data['is_video'] = this.isVideo;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['video'] = this.video;
    data['date'] = this.date;
    data['__v'] = this.iV;
    data['filename'] = this.filename;
    data['index'] = this.index;
    return data;
  }
}

class Question {
  String sId;
  bool isPaid;
  String name;
  String category;
  String date;
  String slug;
  int iV;

  Question(
      {this.sId,
      this.isPaid,
      this.name,
      this.category,
      this.date,
      this.slug,
      this.iV});

  Question.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isPaid = json['is_paid'];
    name = json['name'];
    category = json['category'];
    date = json['date'];
    slug = json['slug'];
    iV = json['__v'];
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
    return data;
  }
}
