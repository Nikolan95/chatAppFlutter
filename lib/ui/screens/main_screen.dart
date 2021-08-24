import 'dart:convert';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/conversation_screen.dart';
import 'package:chat_app/ui/screens/users/profile_screen.dart';
import 'package:chat_app/ui/style.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'car/car_screen.dart';


class MainScreen extends StatefulWidget {
  static final routeName = 'main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token){
      print(token);
      Provider.of<UserProvider>(context, listen: false).setFcmToken(token);
    });
    notification();
  }

  notification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
            print(message.data['message']);
            handleNotification(message.data['message'], false);
            //handleNotification(notification.body, false);
      }
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message){
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
            handleNotification(message.data['message'], false);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
            handleNotification(message.data['message'], false);

      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
      //print(notification.body);
    });
    
  }

  handleNotification(data, bool push){
    var messageJson = json.decode(data);
    var message = MessageModel.fromJson(messageJson);
    Provider.of<ConversationProvider>(context, listen: false).addMessageToConversation(message.conversationId, message);
    print(messageJson);
  }


  final PageController _pageController = new PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          ConversationScreen(),
          CarScreen(),
          Container(
            color: Colors.green,
          ),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        backgroundColor: Style.darkColor,
        onTap: (i) {
          setState(() {
            currentIndex = i;
            _pageController.animateToPage(i,
                duration: kTabScrollDuration, curve: Curves.easeIn);
          });
        },
        //borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.yellow,
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.message,
                color: Colors.yellow,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.yellow,
              icon: Icon(
                Icons.car_repair,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.car_repair,
                color: Colors.yellow,
              ),
              title: Text("My Cars")),
          BubbleBottomBarItem(
              backgroundColor: Colors.yellow,
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.people,
                color: Colors.yellow,
              ),
              title: Text("Friends")),
          BubbleBottomBarItem(
              backgroundColor: Colors.yellow,
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.yellow,
              ),
              title: Text("Profile")),
        ],
      ),
    );
  }
}