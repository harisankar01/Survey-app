import 'dart:io';
import './quiz/Components/Download_pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controller/quiz_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../controller/db.dart';

class ScoreScreen extends StatelessWidget {
  Db data=Db();
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  late int worryscore;
  late int cScore;
  late int sscore;
  ScoreScreen(this.worryscore, this.cScore, this.sscore);

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'Name': data.namee,
      'Age': data.rolle,
      'Country':data.coun,
      'Gender':data.gen,
      'Concentration Disruption Score': cScore,
      'Somatic Trait Anxiety Score':sscore,
      'Worry Score':worryscore
    })
        .then((value) => exit(0))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> _createPdf() async{
    final PdfDocument doc = PdfDocument();
    final PdfPage page = doc.pages.add();
    final Size pageSize = page.getClientSize();
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(34, 156, 253)));
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(182, 173, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width , 90));
    page.graphics.drawString("User Details",
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(170, 80, 200, 100),
        brush: PdfBrushes.blueViolet,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        'Survey Results', PdfStandardFont(PdfFontFamily.helvetica, 35),
        brush: PdfBrushes.red,
        bounds: Rect.fromLTWH(150, 0, pageSize.width/2, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Name: "+(data.namee).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(50, 110, 200, 100),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Roll Number: "+(data.rolle).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(50, 160, 200, 100),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Gender: "+(data.gen).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(50, 210, 200, 100),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Country: "+(data.coun).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(50, 260, 200, 100),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(0, 330, pageSize.width , 10));
    page.graphics.drawString("Scores",
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(190, 320, 200, 100),
        brush: PdfBrushes.blueViolet,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Concentration Disruption Score :"+(cScore).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(50, 370, 300, 100),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Somatic Trait Anxiety Score :"+(sscore).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(50, 430, 300, 100),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Worry Score :"+(worryscore).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(50, 500, 300, 100),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));
    const String footerContent = "THANK YOU FOR TAKING THE SURVEY";

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 25),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(20, pageSize.height - 70, 0, 0));
    List<int> bytes=doc.save();
    doc.dispose();
    Download(bytes);
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 1),
              Text(
                "Results",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: Color.fromRGBO(146, 2, 66, 1)),
              ),
              Spacer(flex: 1,),
              Text(
                "Worry Score= ${_qnController.Worryscore}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 1,),
              Text(
                "Concentration Disruption Score= ${_qnController.CScore}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 1,),
              Text(
                "Somatic Trait Anxiety Score = ${_qnController.Sscore}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 1,),
              ElevatedButton(
                key: Key("2"),
                onPressed: _createPdf,
                child: const Text(
                  "Download Pdf",
                ),),
              ElevatedButton(
                onPressed: addUser,
                child: const Text(
                  "Exit",
                ),),
              Spacer(flex: 1,),
            ],
          )
        ],
      ),
    );
  }
}