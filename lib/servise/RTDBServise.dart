import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:food_menu/model/post_model.dart';


class RTDBService {
  static final _databse = FirebaseDatabase.instance.ref();

  //salads

  static Future<Stream<DatabaseEvent>> addSalads(Post post) async {
    _databse.child("salads").push().set(post.toJson());
    return _databse.onChildAdded;
  }

  static Future<List<Post>> getSalads() async  {
    List<Post> items = [];

        Query _query = _databse.ref.child("salads");
    DatabaseEvent event = await _query.once();

    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      var key=child.key;
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        id:child.key,
        name: map['name'],
        caption: map['caption'],
        img_url : map['img_url'],
        caption1 : map['caption1'],
      );
      post.id=key;
      items.add(post);
    }
    return items;
  }

  static Future<void> deleteSalad(String id) async {
    await _databse.child("salads").child(id).remove().then((_) {
      print("Post muvaffaqiyatli o'chirildi!");
    }).catchError((error) {
      print("Xato yuz berdi: $error");
    });
  }

  //drinks

  static Future<Stream<DatabaseEvent>> addDrink(Post post) async {
    _databse.child("drinks").push().set(post.toJson());
    return _databse.onChildAdded;
  }

  static Future<List<Post>> getDrink() async {
    List<Post> items = [];

    Query _query = _databse.ref.child("drinks");
    DatabaseEvent event = await _query.once();

    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        id:child.key,
        name: map['name'],
        caption: map['caption'],
        img_url : map['img_url'],
        caption1 : map['caption1'],
      );

      items.add(post);
    }
    return items;
  }

  static Future<void> deleteDrink(String id) async {
    await _databse.child("drinks").child(id).remove().then((_) {
      print("Post muvaffaqiyatli o'chirildi!");
    }).catchError((error) {
      print("Xato yuz berdi: $error");
    });
  }

  //foods

  static Future<Stream<DatabaseEvent>> addFoood(Post post) async {
    _databse.child("foods").push().set(post.toJson());
    return _databse.onChildAdded;
  }

  static Future<List<Post>> getFood() async {
    List<Post> items = [];

    Query _query = _databse.ref.child("foods");
    DatabaseEvent event = await _query.once();

    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        id: child.key,
        name: map['name'],
        caption: map['caption'],
        img_url : map['img_url'],
        caption1 : map['caption1'],
      );
      items.add(post);
    }
    return items;
  }

  static Future<void> deleteFood(String id) async {
    await _databse.child("foods").child(id).remove().then((_) {
      print("Post muvaffaqiyatli o'chirildi!");
    }).catchError((error) {
      print("Xato yuz berdi: $error");
    });
  }

  //sweets

  static Future<Stream<DatabaseEvent>> addSweet(Post post) async {
    _databse.child("sweets").push().set(post.toJson());
    return _databse.onChildAdded;
  }

  static Future<List<Post>> getSweet() async {
    List<Post> items = [];

    Query _query = _databse.ref.child("sweets");
    DatabaseEvent event = await _query.once();

    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        id: child.key,
        name: map['name'],
        caption: map['caption'],
        img_url : map['img_url'],
        caption1 : map['caption1'],
      );
      items.add(post);
    }
    return items;
  }

  static Future<void> deleteSweet(String id) async {
    await _databse.child("sweets").child(id).remove().then((_) {
      print("Post muvaffaqiyatli o'chirildi!");
    }).catchError((error) {
      print("Xato yuz berdi: $error");
    });
  }
}