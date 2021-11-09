    import Foundation
    import UserNotifications
    import REIOSSDK
    
    @available(iOS 13.0, *)
    extension AppDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            REiosHandler.setForegroundNotification(data: notification) { (handler) in
                    completionHandler(handler)
                }
    }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            
            print("User Info : \(userInfo.description)")
            
            if let _userInfo = userInfo as? [String: Any] {
                REiosHandler.setCustomNotification(userInfo: _userInfo)
                completionHandler(.newData)
            }
        }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        REiosHandler.setNotificationAction(response: response)
        completionHandler()
    }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            
            // Apns token receiver
            let tokenString = deviceToken.reduce("") { string, byte in
                string + String(format: "%02X", byte)
            }
            print("Device Token : \(tokenString)")
        }
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Failed to Register  : \(error.localizedDescription)")
        }

}
    
