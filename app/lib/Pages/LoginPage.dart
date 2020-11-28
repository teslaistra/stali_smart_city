
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackathon/ServerConnection.dart';
import 'package:video_player/video_player.dart';
import '../Consts.dart';

class LoginPage extends StatefulWidget{

  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver{

  VideoPlayerController _videoController;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    _videoController = VideoPlayerController.asset("assets/start_video.mp4");
    _videoController.addListener(() {
      setState(() {});
    });

    _videoController.initialize().then((_) => setState(() {}));
    _videoController.setLooping(true);
    _videoController.play();

  }


  @override
  void dispose() {
    _videoController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      Consts.updateStatusBar();
    }
  }

  void onPressedLogin() {
    Navigator.pushReplacementNamed(context, "/MainPage");
  }


  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          constraints: BoxConstraints.expand(),
          alignment: Alignment.center,
          color: Colors.white,

          child: Stack(
            children: [

              Container(
                width: double.infinity,
                height: double.infinity,

                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])
                  ),

                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                )
              ),


              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 60),

                child: RaisedButton(
                  onPressed: onPressedLogin,
                  color: Colors.white,
                  textColor: Color(0xFF0066B3),
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),

                  child: Container(
                    width: 293,
                    height: 68,
                    alignment: Alignment.center,

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        RichText(
                          text: TextSpan(
                            style: Consts.buttonText,
                            children: [
                              TextSpan(text: "Войти через гос", style: TextStyle(color: Color(0xFF0066B3)) ),
                              TextSpan(text: "услуги", style: TextStyle(color: Color(0xFFED2F53))),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        )
      ),
    );
  }


}