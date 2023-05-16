//
//  AppDelegate.swift
//  test
//
//  Created by Maheshashok Bijapur on 15/05/23.
//

import UIKit
import UserNotifications
//import Marketo

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let sharedInstance: Marketo = Marketo.sharedInstance()
        sharedInstance.initialize(withMunchkinID: "849-BHY-433",
                                  appSecret: "MHdKWVZLTHoxMnFUNnk0b3FCTWNDbHBI",
                                  launchOptions: launchOptions)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            UNUserNotificationCenter.current().delegate = self
            
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        return true
    }
    
  
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Marketo.sharedInstance().registerPushDeviceToken(deviceToken)
    }
            
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool{
        print("Open URL")
        if #available(iOS 16.0, *) {
            let host = url.host()
            print(host!)
        } else {
            // Fallback on earlier versions
            let host = url.host
            print(host!)
        }
            
        return true
//        return Marketo.sharedInstance().application(app, open: url, sourceApplication: nil, annotation: nil)
    }
    // MARK: Notification handling

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Marketo.sharedInstance().userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert,.badge])
    }
}

