import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thought/models/appmodel.dart';

class DBHelper extends GetxController {
  static Database? _db;
  var category = <Category>[].obs;
  var saves = <Thoughts>[].obs;
  var legends = null;
  var thougts = <Thoughts>[].obs;
  var allthougts = <Thoughts>[].obs;
  var searchlist = <Thoughts>[].obs;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  @override
  onInit() {
    getCategories();
    getallThouhgts();
    super.onInit();
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Books.db");
    bool dbExists = await File(path).exists();

    if (!dbExists) {
      // Copy from asset
      print("start");
      ByteData data = await rootBundle.load("assets/database/trust_thought.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
      // print('file create done');
    }

    var theDb = await openDatabase(path, version: 1);
    return theDb;
  }

  Future<List<Category>> getCategories() async {
    category.clear();
    var dbClient = await db;
    List<Map<String, dynamic>> lists =
        await dbClient!.query('options', orderBy: 'name');
    for (var element in lists) {
      category.add(Category.fromMap(element));
    }
    return category.value;
  }

  Future<List<Thoughts>> getThouhgts(int id) async {
    thougts.clear();
    var dbClient = await db;
    List<Map<String, dynamic>> lists = await dbClient!.rawQuery(
        'SELECT * FROM thoughts WHERE thoughts.option = ${id.toString()} ORDER BY thoughts.text');
    //print(lists.toString());
    for (var element in lists) {
      thougts.add(Thoughts.fromMap(element));
    }
    return thougts.value;
  }

  Future<List<Thoughts>> getSaves() async {
    saves.clear();
    var dbClient = await db;
    List<Map<String, dynamic>> lists = await dbClient!
        .rawQuery('SELECT * FROM thoughts WHERE thoughts.likes = 1');
    //print(lists.toString());
    for (var element in lists) {
      saves.add(Thoughts.fromMap(element));
    }

    return saves;
  }

  Future<bool> checkicon(Thoughts thoughts) async {
    var dbClient = await db;
    var man = await getSaves();
    if (man
        .where((element) => element.name.contains(thoughts.name))
        .toList()
        .length
        .isEqual(1)) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> updatelikes(Thoughts thought) async {
    var dbClient = await db;
    var man = await getSaves();
    print(man);
    if (man
        .where((element) => element.name.contains(thought.name))
        .toList()
        .length
        .isEqual(1)) {
      await dbClient!.rawQuery(
          'UPDATE  thoughts SET "likes" = 0  WHERE "text" = "${thought.name}"');
      print('item add f6s');
      await getSaves();
      return true;
    } else {
      await dbClient!.rawQuery(
          'UPDATE  thoughts SET "likes" = 1  WHERE "text" = "${thought.name}"');
      print('item add fs');
      await getSaves();
      return false;
    }
  }

  Future<List<Thoughts>> getallThouhgts() async {
    allthougts.clear();
    var dbClient = await db;
    List<Map<String, dynamic>> lists =
        await dbClient!.query('thoughts', orderBy: 'text');
    //print(lists.toString());
    for (var element in lists) {
      allthougts.add(Thoughts.fromMap(element));
    }
    return thougts.value;
  }

  Future<Legend> getLegends(int owner) async {
    var dbClient = await db;
    List<Map<String, dynamic>> lists = await dbClient!
        .rawQuery('SELECT owners.* FROM owners WHERE ${owner} = owners.owner');
    for (var element in lists) {
      legends = Legend.fromMap(element);
    }
    return legends;
  }

  Filter(data, query) {
    return data.toLowerCase().contains(query.toLowerCase());
  }

  void Searchtile(String query) {
    final abc =
        allthougts.where((element) => Filter(element.name, query)).toList();
    searchlist.value = abc.obs;
  }
}
//
// Future<List<Topic>> getsaves() async {
//   var dbClient = await db;
//   // List<Topic> data = [];
//   List<Map<String, dynamic>> lists =
//       await dbClient!.rawQuery('Select * from Topics where "saved"= 1');
//   for (var element in lists) {
//     saves.add(Topic.fromMap(element));
//   }
//   //saves.value = data;
//   return saves;
// }

// Delete the database
