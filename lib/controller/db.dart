import 'package:flutter/foundation.dart';

class Db {
   static late final String name;
   static late final String roll;
   String get namee=>name;
   String get rolle=>roll;
  void init(String nae, String rol){
   name=nae;
   roll=rol;
   print(name+roll);
  }

}