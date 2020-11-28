import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/ShadowButton.dart';

import '../Consts.dart';

class InitiativePage extends StatefulWidget{

  State<StatefulWidget> createState() => _InitiativePageState();
}

class _InitiativePageState extends State<InitiativePage> with WidgetsBindingObserver{

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

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 5, top: 50, bottom: 15),
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
                  height: 1000,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF0F0F0),
                          blurRadius: 20,
                          offset: Offset(0,4),
                        ),
                      ]
                  ),

                  child: Column(
                    children: [

                      Container(
                        width: double.infinity,
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Image.asset("assets/Author.png", fit: BoxFit.cover,),
                        ),
                      ),

                      Container(
                          width: double.infinity,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Размещено 10 дней назад", style: Consts.graySubtitle4Text,)
                          )
                      ),

                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only( bottom: 30),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Цифровой двор", style: Consts.title2TextStyle,)
                          )
                      ),

                      Container(
                        child: Container(
                          child: Text("Программно-аппаратный комплекс с клиент-серверной архитектурой построения, предназначенный для обеспечения безопасности населения и предоставления дополнительных IT-сервисов для населения, управляющих, обслуживающих компаний при помощи оборудования аудиовизуального контроля, системы личных кабинетов и мобильного приложения.", style: Consts.subtitleText,),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.thumb_up, color: Consts.grayText),
                                  Text("  "),
                                  Icon(Icons.thumb_down, color: Consts.grayText)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset("assets/comments1.png")
                    ],
                  ),
                ),


              ],
            ),
          )

      ),
    );
  }


}