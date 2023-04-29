import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  //!=============================== Constructor ===============================
  static const NotificationService _singleton = NotificationService._internal();
  factory NotificationService() {
    return _singleton;
  }
  const NotificationService._internal();
  //!=============================== Properties ================================
  static final _instance = FirebaseMessaging.instance;

  //!================================ Methods ==================================
  static Future<void> init() async {
    try {
      final futureList = [
        _requestNotificationPermission(),
        _setupOnNotificationOpenApp(),
      ];

      // Only setup [Local Notifications] for Android, it's not needed for IOS
      // as [FOR ANDROID ONLY] the Firebase Android SDK will block displaying
      // any FCM notification  no matter what Notification Channel has been set
      if (Platform.isAndroid) {
        futureList.addAll([
          _LocalNotificationService.androidEnableForegroundNotifications(),
          _LocalNotificationService.initLocalNotification(),
          _setupForegroundNotificationHandler(),
        ]);
      }

      await Future.wait(
        futureList,
      );
    } catch (e) {}
  }

  //!==================================================
  static Future<void> _iosEnableForegroundNotifications() async {
    await _instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  //!==================================================
  static Future<void> _setupForegroundNotificationHandler() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? androidNotification =
            message.notification?.android;
        AppleNotification? appleNotification = message.notification?.apple;
        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null &&
            (androidNotification != null || appleNotification != null)) {
          showLocalNotification(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            payload: message.data['payload'],
            icon: androidNotification?.smallIcon,
            imageUrl: androidNotification?.imageUrl,
          );
        }
      },
    );
  }

  //!==================================================
  // It is assumed that all messages contain a data field with the key 'type'
  static Future<void> _setupOnNotificationOpenApp() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await _instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleOnNotificationOpenApp(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOnNotificationOpenApp);
  }

  //!==================================================
  static void _handleOnNotificationOpenApp(RemoteMessage remoteMessage) {
    onTapNotification(remoteMessage: remoteMessage);
  }

  //!==================================================
  static Future<void> _requestNotificationPermission() async {
    NotificationSettings settings = await _instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        break;
      case AuthorizationStatus.provisional:
        break;
      default:
    }
  }

  //!==================================================
  /// [Message] is For Background/Terminated Notifications
  /// [id, title, body, payload] is For Background Notifications
  static Future<void> onTapNotification({
    RemoteMessage? remoteMessage,
    int? id,
    String? title,
    String? body,
    String? payload,
  }) async {
    // Logg
    try {
      payload ??= remoteMessage?.data['payload'];
      if (payload == null) return;
    } on Exception catch (e) {}
  }

  static Future<void> showLocalNotification({
    int? id,
    String? title,
    String? body,
    NotificationDetails? notificationDetails,
    String? payload,
    String? icon,
    String? imageUrl,
  }) async {
    await _LocalNotificationService._flutterLocalNotificationsPlugin.show(
      id!,
      title,
      body,
      notificationDetails ??
          await _LocalNotificationService._getNotificationDetails(
            icon,
            imageUrl: imageUrl,
          ),
      payload: payload,
    );
  }
//!===========================================================================
}

class _LocalNotificationService {
  //!=============================== Constructor ===============================
  static const _LocalNotificationService _singleton =
      _LocalNotificationService._internal();
  factory _LocalNotificationService() {
    return _singleton;
  }
  const _LocalNotificationService._internal();
  //!=============================== Properties ================================

  // To ensure that [Forground] Notifications are not dismissed.
  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
    'notification_high_importance_channel', // id
    'notification_high_importance_channel', // title
    description: 'notification_high_importance_channel Description',
    importance: Importance.max,
  );

  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //!================================ Methods ==================================

  static Future<void> initLocalNotification() async {
    const iosSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: _handleIOSOnNotificationTap,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const initializationSettings = InitializationSettings(
      iOS: iosSettings,
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: _handleOnNotificationTap,
      onDidReceiveNotificationResponse: _handleOnNotificationTap,
    );
  }

  //!==================================================
  static void _handleOnNotificationTap(
      NotificationResponse? notificationResponse) {
    NotificationService.onTapNotification(
      payload: notificationResponse?.payload,
    );
  }

  //!==================================================
  static void _handleIOSOnNotificationTap(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    NotificationService.onTapNotification(
      payload: payload,
      id: id,
      body: body,
      title: title,
    );
  }

  //!==================================================
  static Future<void> androidEnableForegroundNotifications() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);
  }
  //!==================================================

  static Future<NotificationDetails> _getNotificationDetails(
    String? icon, {
    String? imageUrl,
  }) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidNotificationChannel.id,
        _androidNotificationChannel.name,
        color: _androidNotificationChannel.ledColor,
        channelDescription: _androidNotificationChannel.description,
        importance: Importance.max,
        priority: Priority.high,
        colorized: true,
      ),
    );
  }

  //!==================================================

  //!===========================================================================
  //!===========================================================================
}
