import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LocalNotifications(),
    );
  }
}


class LocalNotifications extends StatefulWidget {

  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {
  FlutterLocalNotificationsPlugin localNotifications = FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings androidInitializationSettings;

  IOSInitializationSettings iosInitializationSettings;

  InitializationSettings initializationSettings;

  @override
  void initState() { 
    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings("app_icon");
    iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(androidInitializationSettings, iosInitializationSettings);

    await localNotifications.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
  }

  void _showNotificationsAfterSecond() async {

    await notificationAfterSecond();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Chanel_ID',
      'Chanel tittle',
      'channel body',
      priority: Priority.High,
      importance: Importance.Max,
      ticker: 'test'
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    await localNotifications.show(0, "Hola mundo", "Este es el cuerpo de la notificacion", notificationDetails);
  }

  Future<void> notificationAfterSecond() async {

    var timeDelayed = DateTime.now().add(Duration(seconds: 5));

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Second_Chanel_ID',
      'Second Chanel tittle',
      'channel body',
      priority: Priority.High,
      importance: Importance.Max,
      ticker: 'test'
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    await localNotifications.schedule(1, "Hola mundo", "Este es el cuerpo de la notificacion", timeDelayed, notificationDetails);
  }

  Future onSelectNotification(String payLoad){
    if (payLoad != null) {
      print(payLoad);
    }

    // podemos configurar la navegación para navegar a otra pantalla
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payLoad) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: (){
            print("");
          },
          child: Text("Okay"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text("Mostrar Notificación", style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: _showNotifications,
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("Mostrar despues de unos segundos", style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: _showNotificationsAfterSecond,
            ),
          ],
        ),
      ),
    );
  }
}