

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Consts.dart';
import 'package:hackathon/ServerConnection.dart';
import 'package:hackathon/Widgets/InitiativeWidget.dart';
import 'package:hackathon/Widgets/ShadowButton.dart';
import 'package:hackathon/Widgets/VoteWidget.dart';

class MainPage extends StatefulWidget {

  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver{

  int navBarIndex = 0;
  List <Widget> listInitiatives = [];
  List <Widget> listVoteWidgets = [];
  List <Vote> listVotes = [];


  @override
  void initState() {
    listVotes.add(Vote(title: "Медицинские учреждения", subtitle: "Наличие цифровых сервисов, упрощающих процесс обращения в медицинские учреждения", isDone: true));
    listVotes.add(Vote(title: "Школьный эл.журнал", subtitle: "Собираем данные о качестве и наличии цифровых услуг в школах.", isDone: true));
    listVotes.add(Vote(title: "Жилищно коммунальное хозяйство", subtitle: "Давайте вместе сделаем среду лучше. Поговорим о капитальном ремонте,...", isDone: false));

    listVoteWidgets.add(VoteWidget(vote: listVotes[0],));
    listVoteWidgets.add(VoteWidget(vote: listVotes[1],));
    listVoteWidgets.add(VoteWidget(vote: listVotes[2],));

    getInitiatives();

    WidgetsBinding.instance.addObserver(this);
    Consts.updateStatusBarDark();
    super.initState();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      Consts.updateStatusBarDark();
    }
  }

  void onPressedComplaint() {
    Navigator.pushNamed(context, "/ComplaintPage");
  }

  void onNavbarTapped(int index) {
    setState(() {
      navBarIndex = index;
    });
  }

  void getInitiatives() {
    ServerConnection.topInitiatives().then((value) {
      setState(() {
        listVotes[0].isDone = true;
        for (int i = 0; i < value.length; i++) {
          listInitiatives.add(InitiativeWidget(
            title: value[i]["short_description"],
            subtitle: value[i]["long_description"],
            author: value[i]["author_name"],
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController textCon = TextEditingController();

    List<Widget> menus = [
      ListView(

        children: [

          Column(
            children: [
              Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 27, top: 20, bottom: 60),
                  alignment: Alignment.topLeft,
                  child: Text("Лента\nгорода", style: Consts.titleTextStyle,),
                ),

                Container(
                  width: 344,
                  height: 79,
                  child: ShadowButton(
                      child: MaterialButton(
                        elevation: 5,
                        onPressed: onPressedComplaint,
                        color: Color(0xFF0075CD),
                        textColor: Colors.white,
                        child: Text("Отправить жалобу", style: Consts.normalButtonText,),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                      )
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 27, top: 30, bottom: 10),
                  alignment: Alignment.topLeft,
                  child: Text("ОПРОС ДНЯ:", style: Consts.graySubtitleText,),
                ),

                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  height: 80,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF0F0F0),
                          blurRadius: 40,
                          offset: Offset(0,4),
                        ),
                      ]
                  ),

                  child: FlatButton(
                    onPressed: (){onNavbarTapped(2);},
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 18),
                          alignment: Alignment.centerLeft,
                          child: Text("Городской транспорт", style: Consts.title3TextStyle,),
                        ),

                        Container(
                          padding: EdgeInsets.only(right: 18),
                          alignment: Alignment.centerRight,
                          child: Text("0/3 >", style: Consts.graySubtitle2Text,),
                        )

                      ],
                    ),
                  ),
                  ),

                Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 27, top: 30, bottom: 20, right: 8),

                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Инициативы:", style: Consts.title2TextStyle,),
                        ),
                        Container(
                            height: 34,
                            alignment: Alignment.centerRight,


                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              color: Consts.subButtonColor,
                              onPressed: (){},
                              elevation: 0,

                              child: Text("Предложить", style: Consts.grayButtonText,),

                            )
                        )
                      ],
                    )
                ),
              ],
            ),
              Column(
                children: listInitiatives,
              )]
          )
        ],
      ),
      ListView(

        children: [

          Column(
            children: [

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 27, top: 20, bottom: 30),
                    alignment: Alignment.topLeft,
                    child: Text("Поиск", style: Consts.titleTextStyle,),
                  ),
                ],
              ),

              Container(
                height: 45,
                margin: EdgeInsets.only(left: 27, bottom: 15, right: 27),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFEFF3FF),
                ),

                child: Padding(
                    padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          minLines: 1,
                          maxLines: 1,
                          controller: textCon,
                          decoration: InputDecoration.collapsed(
                            hintText: "Введите название инициативы"
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.search, color: Consts.grayText)
                      ),
                    ],
                  )
                )
              ),

              Container(
                margin: EdgeInsets.only(left: 27, bottom: 220, right: 27),
                width: double.infinity,
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.filter_list_outlined, color: Consts.grayText),
                      Text("Фильтры", style: Consts.grayButtonText,)
                    ],
                  ),
                ),
              ),

              Container(
                child: Text("Ничего не найдено :(", style: Consts.grayButtonText),
              )
            ],
          )
        ],
      ),
      ListView(

        children: [

          Column(
            children: [

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 27, top: 20, bottom: 30),
                    alignment: Alignment.topLeft,
                    child: Text("Опросы", style: Consts.titleTextStyle,),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: VoteWidget(vote: Vote(title: "Городской транспорт", subtitle: "Мы хотим стать лучше, поэтому, пожалуйста, расскажите нам об общественном транспорте в вашем городе.", isDone: false),),
                  )
                ],
              ),
              Column(
                children: listVoteWidgets,
              ),
            ],
          )
        ],
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        color: Color(0xFFF9FBFE),

        child: menus.elementAt(navBarIndex),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          boxShadow: [
            BoxShadow(color: Color(0xFFD1D1D1), spreadRadius: 0, blurRadius: 10),
          ],
        ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),

                BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text('Главная')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), title: Text('Поиск')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.messenger), title: Text('Опросы')),
                  ],
                  currentIndex: navBarIndex,
                  onTap: onNavbarTapped,
                ),
              ],
            )
          )
      )
    );
  }


}