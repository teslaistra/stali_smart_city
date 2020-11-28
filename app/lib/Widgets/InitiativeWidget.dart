
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hackathon/Consts.dart';

class InitiativeWidget extends StatelessWidget{
  final String title, subtitle, author;

  InitiativeWidget({this.title, this.subtitle, this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
      child: FlatButton(
        onPressed: (){Navigator.pushNamed(context, "/InitiativePage");},
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(title, style: Consts.title3TextStyle,),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(subtitle, style: Consts.subtitleText,),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(author, style: Consts.grayButtonText,),
              ),
            ),

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
            )
          ],
        ),
      )
    );
  }

}