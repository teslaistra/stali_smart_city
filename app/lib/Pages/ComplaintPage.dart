

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Consts.dart';
import 'package:hackathon/Widgets/ShadowButton.dart';

class ComplaintPage extends StatefulWidget{

  State<StatefulWidget> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> with WidgetsBindingObserver{

  TextEditingController textCon = TextEditingController();

  void onPressedBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        color: Color(0xFFF9FBFE),

        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, top: 50, bottom: 60),
              alignment: Alignment.centerLeft,
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: onPressedBack,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, size: 20, color: Consts.grayText,),
                      Text("Назад", style: Consts.graySubtitle3Text,)
                    ],
                  )
              )
            ),

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 27, bottom: 30),
              child: Container(
                alignment: Alignment.centerLeft,
                  child: Text("Ваша жалоба:", style: Consts.title2TextStyle,)
              )
            ),

            Container(
              height: 340,
              margin: EdgeInsets.only(left: 27, bottom: 30, right: 27),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFEFF3FF),
              ),

              child: Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  minLines: 18,
                  maxLines: 18,
                  controller: textCon,
                  decoration: InputDecoration.collapsed(
                      hintText: "Конкретный бланк и содержание жалобы законом не установлены. Однако постарайтесь ёмко изложить основную суть проблемы. Старайтесь избегать художественных выражении и метафор. Желательно соблюдать правила стилистики, орфографии и пунктуации."
                  ),
                ),
              ),
            ),

            Container(
              height: 56,
              margin: EdgeInsets.only(left: 27, bottom: 30, right: 27),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFEFF3FF),
              ),

              child: Padding(
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Прикрепить файл", style: Consts.grayButtonText,),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.transit_enterexit, color: Consts.grayText)
                    ),
                  ],
                )
              ),
            ),

            Container(
              width: 344,
              height: 68,
              child: ShadowButton(
                  child: MaterialButton(
                    elevation: 5,
                    onPressed: (){onPressedBack();},
                    color: Color(0xFF0075CD),
                    textColor: Colors.white,
                    child: Text("Отправить", style: Consts.normalButtonText,),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                  )
              ),
            ),


          ],
        ),

      ),
    );
  }


}