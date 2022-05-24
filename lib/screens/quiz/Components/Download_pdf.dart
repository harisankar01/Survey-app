import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> Download(List<int> bytes) async{
  final path=(await getExternalStorageDirectory())?.path;
  const String filename="SurveyResults.pdf";
  final file=File('$path/$filename');
  await file.writeAsBytes(bytes,flush: true);
  OpenFile.open('$path/$filename');
}