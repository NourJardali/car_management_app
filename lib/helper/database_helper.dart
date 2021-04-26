import 'package:car_management_app/modals/car_expert.dart';
import 'package:car_management_app/modals/car_owner.dart';
import 'package:car_management_app/modals/rating.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper.createInstance();

  factory DatabaseHelper() {
    databaseHelper ??= DatabaseHelper.createInstance();
    return databaseHelper;
  }

  static DatabaseHelper databaseHelper;
  static Database db;

  String ownersTable = 'car_owners';
  String ownersId = 'ownerId';
  String ownerFName = 'owner_firstname';
  String ownderLName = 'owner_lastname';
  String ownerEmail = 'owner_email';
  String ownerPhone = 'owner_phonenb';
  String ownerCarDetails = 'owner_car_details';
  String ownerPinCode = 'owner_pin_code';
  String ownerSatet = 'owner_state';
  String ownerLat = 'latitude';
  String ownerLong = 'longitude';

  String expertsTable = 'car_experts';
  String expertsId = 'expertId';
  String expertFName = 'expert_firstname';
  String expertLName = 'expert_lastname';
  String expertEmail = 'expert_email';
  String expertPhone = 'expert_phonenb';
  String expertType = 'expert_type';
  String garageName = 'garageName';
  String expertDescription = 'expert_desc';
  String expert_location = 'expert_location';
  String available = 'available';
  String expertLatitude = 'latitude';
  String expertLongitude = 'longtitude';

  String ratingTable = 'ratings';
  String ratingId = 'rateId';
  String exId = 'expertId';
  String rate = 'rate';

  Future<Database> get database async {
    db ??= await initializeDatabase();
    return db;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    var directory = await getApplicationDocumentsDirectory();
    var path = directory.path + 'carsapp.db';
    // Open/create the database at a given path
    var carsDatabase =
        await openDatabase(path, version: 13, onCreate: createDb);
    return carsDatabase;
  }

  void createDb(Database _database, int newversion) async {
    await _database.execute(
        'CREATE TABLE $ownersTable($ownersId INTEGER PRIMARY KEY AUTOINCREMENT, $ownerFName TEXT, $ownderLName TEXT, $ownerEmail TEXT, $ownerPhone TEXT, $ownerCarDetails TEXT, $ownerPinCode TEXT, $ownerSatet TEXT, $ownerLat TEXT, $ownerLong TEXT)');

    await _database.execute(
        'CREATE TABLE $expertsTable($expertsId INTEGER PRIMARY KEY AUTOINCREMENT, $expertFName TEXT, $expertLName TEXT, $expertEmail TEXT, $expertPhone TEXT, $expertType TEXT, $garageName TEXT, $expertDescription TEXT, $expert_location TEXT, $available INTEGER, $expertLatitude TEXT, $expertLongitude TEXT)');

    await _database.execute(
        'CREATE TABLE $ratingTable($ratingId INTEGER PRIMARY KEY AUTOINCREMENT, $exId INTEGER, $rate DOUBLE)');
  }

  //Fetch Operation: Get all car_owners objects from database
  Future<List<Map<String, dynamic>>> getCarOwnersList() async {
    var _db = await database;
    var result = await _db.query(ownersTable, orderBy: '$ownerFName ASC');
    return result;
  }

  //Fetch Operation: Get all car_experts objects from database
  Future<List<Map<String, dynamic>>> getCarExpertsList() async {
    var _db = await database;
    var result = await _db.query(expertsTable, orderBy: '$expertFName ASC');
    return result;
  }

  //Fetch Operation: Get all rating objects from database
  Future<List<Map<String, dynamic>>> getRateList() async {
    var _db = await database;
    var result = await _db.query(ratingTable, orderBy: '$ratingId ASC');
    return result;
  }

  //Insert Operation: Insert car_owner object to database
  Future<int> insertCarOwner(CarOwner carOwner) async {
    var _db = await database;
    var result = await _db.insert(ownersTable, carOwner.toMap());
    return result;
  }

  //Insert Operation: Insert car_expert object to database
  Future<int> insertCarExpert(CarExpert carExpert) async {
    var _db = await database;
    var result = await _db.insert(expertsTable, carExpert.toMap());
    return result;
  }

  //Insert Operation: Insert rating object to database
  Future<int> insertRate(Rating rating) async {
    var _db = await database;
    var result = await _db.insert(ratingTable, rating.toMap());
    return result;
  }

  //Update Operation: Update a car_owner object and save it to database
  Future<int> updateCarOwner(CarOwner carOwner) async {
    var _db = await database;
    var result = await _db.update(ownersTable, carOwner.toMap(),
        where: '$ownersId = ?', whereArgs: [carOwner.carOwnderId]);
    return result;
  }

  //Update Operation: Update a car_expert object and save it to database
  Future<int> updateCarExpert(CarExpert carExpert) async {
    var _db = await database;
    var result = await _db.update(expertsTable, carExpert.toMap(),
        where: '$expertsId = ?', whereArgs: [carExpert.carExpertId]);
    return result;
  }

  //Update Operation: Update a rating object and save it to database
  Future<int> updateRate(Rating rating) async {
    var _db = await database;
    var result = await _db.update(ratingTable, rating.toMap(),
        where: '$ratingId = ?', whereArgs: [rating.rateId]);
    return result;
  }

  //Get the 'Map List' [List<Map>] and convert it to 'owners list' [List<CarOwner]
  Future<List<CarOwner>> getOwnersList() async {
    //get 'Map List' from database
    var ownersMapList = await getCarOwnersList();
    //count the number of map entries in db table
    var count = ownersMapList.length;
    var ownersList = <CarOwner>[];
    //for loop to create a 'owners list' from a 'Map List'
    for (var i = 0; i < count; i++) {
      ownersList.add(CarOwner.fromMapObject(ownersMapList[i]));
    }
    return ownersList;
  }

  //Get the 'Map List' [List<Map>] and convert it to 'experts list' [List<CarExpert>]
  Future<List<CarExpert>> getExpertsList() async {
    //get 'Map List' from database
    var expertsMapList = await getCarExpertsList();
    //count the number of map entries in db table
    var count = expertsMapList.length;
    var expertsList = <CarExpert>[];
    //for loop to create a 'experts list' from a 'Map List'
    for (var i = 0; i < count; i++) {
      expertsList.add(CarExpert.fromMapObject(expertsMapList[i]));
    }
    return expertsList;
  }

  //Get the 'Map List' [List<Map>] and convert it to 'rating list' [List<Rating>]
  Future<List<Rating>> getRates() async {
    //get 'Map List' from database
    var rateList = await getRateList();
    //count the number of map entries in db table
    var count = rateList.length;
    var ratesList = <Rating>[];
    //for loop to create a 'experts list' from a 'Map List'
    for (var i = 0; i < count; i++) {
      ratesList.add(Rating.fromMapObject(rateList[i]));
    }
    return ratesList;
  }
}
