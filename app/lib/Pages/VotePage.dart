import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/ShadowButton.dart';

import '../Consts.dart';

class VotePage extends StatefulWidget{

  State<StatefulWidget> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> with WidgetsBindingObserver{

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
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 27, bottom: 10),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Городской\nтранспорт", style: Consts.titleTextStyle,)
                  )
              ),

              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 27, bottom: 30),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Опрос", style: Consts.graySubtitleText,)
                  )
              ),

              Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 10),
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
                  child: Image.asset("assets/Board1.png")
              ),

              Container(
                  height: 140,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 10),
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
                  child: Image.asset("assets/Board 2.png",)
              ),

              Container(
                  height: 140,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 30),
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
                  child: Image.asset("assets/Board 3.png",)
              ),

              Container(
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 50),
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
        )

      ),
    );
  }


}