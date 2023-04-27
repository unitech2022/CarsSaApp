import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // TODO: Add your Google Maps API key
        GMSServices.provideAPIKey("AIzaSyBjkvg75dnn4qa2_0U9maqdZCiG3d2YLwY")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
