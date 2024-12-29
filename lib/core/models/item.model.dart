import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ItemModel {
  String id;
  Timestamp time;

  ItemModel({ required this.id, required this.time });

}