//
//  AppDelegate.swift
//  visionbank
//
//  Created by Rajaram on 08/11/21.
//

import UIKit


import REIOSSDK

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate, REiosSmartLinkReceiver, REiosNotificationReceiver, UNUserNotificationCenterDelegate {
   
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       registerForRemoteNotification()
        REiosHandler.initSdk(withAppId: "6036e22e-4a43-40e1-ba90-b6000917dc45", notificationCategory: [], success: { status in
            print("success")
        }) { message in
            print("\(message)")
        }
        UNUserNotificationCenter.current().delegate = self
        REiosHandler.smartLinkDelegate = self
        REiosHandler.notificationDelegate = self
       
        
        return true
    }
    
    func registerForRemoteNotification() {

                let center  = UNUserNotificationCenter.current()
                center.delegate = self as? UNUserNotificationCenterDelegate
                center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                    if error == nil{
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }

        }

    func didReceiveSmartLink(data: [String : Any]) {
        print("Did Receive Smart Link Call \(data.description)")
    }
    
    func didReceiveResponse(data: [String : Any]) {
        print("Did Receive Response \(data.description)")
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

