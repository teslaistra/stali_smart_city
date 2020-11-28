

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Consts.dart';

class ShadowButton extends StatelessWidget{
  final Widget child;

  ShadowButton({this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE4E4E4),
            blurRadius: 10,
            offset: Offset(0,4),
          ),
          BoxShadow(
              color: Consts.blueShadow,
              blurRadius: 260,
              offset: Offset(0,0),
          )
        ]
      ),
      child: this.child,
    );
  }


}