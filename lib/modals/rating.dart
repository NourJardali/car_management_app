class Rating {
  Rating({this.expertId, this.rate});

  Rating.withId(
    this.id,
    this.expertId,
    this.rate,
  );

  //Extract a Rating object from a Map object
  Rating.fromMapObject(Map<String, dynamic> map) {
    id = map['rateId'];
    expertId = map['expertId'];
    rate = map['rate'];
  }

  int id;
  int expertId;
  double rate;

  int get rateId => id;

  int get expert => expertId;

  double get rateNb => rate;

  set rateId(int i) {
    id = i;
  }

  set expert(int i) {
    expertId = i;
  }

  set rateNb(double r) {
    rate = r;
  }

  //Convert a Rating object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['rateId'] = id;
    }
    map['expertId'] = expertId;
    map['rate'] = rate;
    return map;
  }
}
