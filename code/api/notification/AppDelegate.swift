import UIKit
import Flutter

//import the following
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  // add the following
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback {(registry) in GeneratedPluginRegistrant.register(with: registry)}
    GeneratedPluginRegistrant.register(with: self)
    //add the following
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
