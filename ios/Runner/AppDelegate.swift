import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller = window.rootViewController as! FlutterViewController
    
    let methodChannel = FlutterMethodChannel(name:"com.example/platforms",binaryMessenger:controller.binaryMessenger)
    
    methodChannel.setMethodCallHandler{
        (call, result) in
        if call.method == "callNative"{
            if let arguments = call.arguments as? [String: Any],
                               let flutterMessage = arguments["flutter_message"] as? String {
                               self.showToast(message: flutterMessage)
            }
            let message = "Hello From IOS Native"
            result(message)
        }
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func showToast(message: String) {
            DispatchQueue.main.async {
                let toastLabel = UILabel()
                toastLabel.text = message
                toastLabel.textColor = .white
                toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                toastLabel.textAlignment = .center
                toastLabel.font = UIFont.systemFont(ofSize: 14.0)
                toastLabel.numberOfLines = 0
                
                let screenSize = UIScreen.main.bounds.size
                let width = min(screenSize.width - 40, 300)
                let height: CGFloat = 50
                toastLabel.frame = CGRect(x: (screenSize.width - width) / 2,
                                           y: screenSize.height - height - 100,
                                           width: width, height: height)
                toastLabel.layer.cornerRadius = 10
                toastLabel.clipsToBounds = true
                
                if let keyWindow = UIApplication.shared.keyWindow {
                    keyWindow.addSubview(toastLabel)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        toastLabel.removeFromSuperview()
                    }
                }
            }
        }
}
