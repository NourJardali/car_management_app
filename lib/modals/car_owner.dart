class CarOwner {
  CarOwner({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNb,
    this.carDetails,
    this.pinCode,
    this.state,
    this.latitude,
    this.longitude,
  });

  CarOwner.withId(
    this.carOwnderId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNb,
    this.carDetails,
    this.latitude,
    this.longitude,
  );

  //Extract a CarOwner object from a Map object
  CarOwner.fromMapObject(Map<String, dynamic> map) {
    carOwnderId = map['ownerId'];
    firstName = map['owner_firstname'];
    lastName = map['owner_lastname'];
    email = map['owner_email'];
    phoneNb = map['owner_phonenb'];
    carDetails = map['owner_car_details'];
    pinCode = map['owner_pin_code'];
    state = map['owner_state'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  int carOwnderId;
  String firstName;
  String lastName;
  String email;
  String phoneNb;
  String carDetails;
  String pinCode;
  String state;
  String latitude;
  String longitude;

  int get id => carOwnderId;

  String get fName => firstName;

  String get lName => lastName;

  String get emailAdd => email;

  String get number => phoneNb;

  String get details => carDetails;

  String get pin => pinCode;

  String get ownerState => state;

  String get longt => longitude;

  String get lat => latitude;

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

  set details(String carDt) {
    carDetails = carDt;
  }

  set pin(String p) {
    pinCode = p;
  }

  set ownerState(String s) {
    state = s;
  }

  set longt(String longt) {
    longitude = longt;
  }

  set lat(String lat) {
    latitude = lat;
  }

  //Convert a CarOwner object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['ownerId'] = carOwnderId;
    }
    map['owner_firstname'] = firstName;
    map['owner_lastname'] = lastName;
    map['owner_email'] = email;
    map['owner_phonenb'] = phoneNb;
    map['owner_car_details'] = carDetails;
    if (pinCode != null) {
      map['owner_pin_code'] = pinCode;
    } else {
      map['owner_pin_code'] = '';
    }
    if (state != null) {
      map['owner_state'] = state;
    } else {
      map['owner_state'] = '';
    }
    if (latitude != null) {
      map['latitude'] = latitude;
    } else {
      map['latitude'] = '';
    }
    if (longitude != null) {
      map['longitude'] = longitude;
    } else {
      map['longitude'] = '';
    }
    return map;
  }
}
