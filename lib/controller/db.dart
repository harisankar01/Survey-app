import 'package:flutter/foundation.dart';

class Db {
   static late final String name;
   static late final String roll;
   static late final String country;
   static late final String gender;

   String get namee=>name;
   String get rolle=>roll;
   String get coun=>country;
   String get gen=>gender;
   void init(String nae, String rol,String cc,String gg){
   name=nae;
   roll=rol;
   country=cc;
   gender=gg;
   print(name+roll);
  }

}