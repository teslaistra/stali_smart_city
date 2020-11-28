

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Consts.dart';

class VoteWidget extends StatefulWidget {
  Vote vote;

  VoteWidget({this.vote});

  @override
  State<StatefulWidget> createState() => _VoteWidgetState(vote: vote);
}

class _VoteWidgetState extends State<VoteWidget> {
  Vote vote;

  _VoteWidgetState({this.vote});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
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
      child: FlatButton(
        onPressed: (){Navigator.pushNamed(context, "/VotePage");},
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
                      child: Text(vote.title, style: Consts.title3TextStyle,),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(vote.subtitle, style: Consts.graySubtitle4Text,),
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
                child: Text((vote.isDone? "Опрос пройден": ""), style: Consts.subtitleText,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Vote {
  String title, subtitle;
  bool isDone = false;

  Vote({this.title, this.subtitle, this.isDone});
}