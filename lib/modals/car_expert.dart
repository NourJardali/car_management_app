class CarExpert {
  CarExpert(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNb,
      this.expertType,
      this.garageName,
      this.description,
      this.location,
      this.available,
      this.latitude,
      this.longitude});

  CarExpert.withId(
      this.carExpertId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNb,
      this.expertType,
      this.garageName,
      this.description,
      this.location,
      this.available,
      this.latitude,
      this.longitude);

  //Extract a CarExpert object from a Map object
  CarExpert.fromMapObject(Map<String, dynamic> map) {
    carExpertId = map['expertId'];
    firstName = map['expert_firstname'];
    lastName = map['expert_lastname'];
    email = map['expert_email'];
    phoneNb = map['expert_phonenb'];
    expertType = map['expert_type'];
    garageName = map['garageName'];
    description = map['expert_desc'];
    location = map['expert_location'];
    available = map['available'];
    latitude = map['latitude'];
    longitude = map['longtitude'];
  }

  int carExpertId;
  String firstName;
  String lastName;
  String email;
  String phoneNb;
  String expertType;
  String garageName;
  String description;
  String location;
  int available;
  String latitude;
  String longitude;

  int get id => carExpertId;

  String get fName => firstName;

  String get lName => lastName;

  String get emailAdd => email;

  String get number => phoneNb;

  String get type => expertType;

  String get garage => garageName;

  String get desc => description;

  int get isAvailable => available;

  String get longt => longitude;

  String get lat => latitude;

  String get loca => location;

  set fName(String fName) {
    if (fName.length <= 255) {
      firstName = fName;
    }
  }

  set lName(String lName) {
    if (lName.length <= 255) {
      lastName = lName;
    }
  }

  set emailAdd(String emailAdd) {
    if (emailAdd.length <= 255) {
      email = emailAdd;
    }
  }

  set number(String number) {
    if (number.length <= 8) {
      phoneNb = number;
    }
  }

  set type(String type) {
    expertType = type;
  }

  set garage(String garage) {
    garageName = garage;
  }

  set loca(String l) {
    location = l;
  }

  set desc(String desc) {
    description = desc;
  }

  set isAvailable(int i) {
    available = i;
  }

  set longt(String longt) {
    longitude = longt;
  }

  set lat(String lat) {
    latitude = lat;
  }

  //Convert a CarExpert object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['expertId'] = carExpertId;
    }
    map['expert_firstname'] = firstName;
    map['expert_lastname'] = lastName;
    map['expert_email'] = email;
    map['expert_phonenb'] = phoneNb;
    map['expert_type'] = expertType;
    map['garageName'] = garageName;
    map['expert_desc'] = description;
    map['expert_location'] = location;
    map['available'] = available;
    map['latitude'] = latitude;
    map['longtitude'] = longitude;
    return map;
  }
}
