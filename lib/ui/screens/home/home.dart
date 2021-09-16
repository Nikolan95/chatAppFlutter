import 'dart:convert';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:chat_app/constants/style.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/chat/chat_list.dart';
import 'package:chat_app/ui/screens/user/user_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

//import '../../../main.dart';
import '../car/car_list.dart';

class Home extends StatefulWidget {
  static final routeName = 'main';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print(token);
      Provider.of<UserProvider>(context, listen: false).setFcmToken(token);
    });
    notification();
  }

  notification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        // flutterLocalNotificationsPlugin.show(
        //     notification.hashCode,
        //     notification.title,
        //     notification.body,
        //     NotificationDetails(
        //       android: AndroidNotificationDetails(
        //         channel.id,
        //         channel.name,
        //         channel.description,
        //         color: Colors.blue,
        //         playSound: true,
        //         icon: '@mipmap/ic_launcher',
        //       ),
        //     ));
        if (message.notification.body != null) {
          print(message.data['message']);
          handleNotification(message.data['message'], false);
        } else {
          print(message.data['message']);
          //handleNotification(message.data['message'], false);
        }
        //handleNotification(notification.body, false);
      }
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      handleNotification(message.data['message'], false);
      return null;
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
      print(notification.body);
    });
  }

  handleNotification(data, bool push) {
    //print(data);
    var messageJson = json.decode(data);
    //print(messageJson['image'] + 'to je to');
    var message = ChatMessage.fromJson(messageJson);
    //print(message.toJson());
    //print(message.conversationId);
    Provider.of<ChatProvider>(context, listen: false)
        .addMessageToChat(message.chatId, message);
    //print(messageJson);
  }

  final PageController _pageController = new PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[ChatList(), CarList(), UserProfile()],
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
              backgroundColor: Style.primaryColor,
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.message,
                color: Style.primaryColor,
              ),
              title: Text("Chats")),
          BubbleBottomBarItem(
              backgroundColor: Style.primaryColor,
              icon: Icon(
                Icons.car_repair,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.car_repair,
                color: Style.primaryColor,
              ),
              title: Text("Fahrzeuge")),
          BubbleBottomBarItem(
              backgroundColor: Style.primaryColor,
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Style.primaryColor,
              ),
              title: Text("Profil")),
        ],
      ),
    );
  }
}
