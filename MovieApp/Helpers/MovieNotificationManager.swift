//
//  MovieNotificationManager.swift
//  MovieApp
//
//  Created by Mine Rala on 22.10.2022.
//

import UIKit
import UserNotifications
import FirebaseMessaging

// MARK: - NOTE
// Apple Developer hesabım olmadığı için apns key yoktur.
// Notification için kod implemente edildi.
// Eğer firebase client'ına apns key girilirse push notification atacaktır.

final class MovieNotificationManager: NSObject, MessagingDelegate {
    static let shared = MovieNotificationManager()
    private(set) var deviceToken: Data?
    private(set) var authorizationOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    let notificationCenter = UNUserNotificationCenter.current()
    private(set) var authorizationStatus: UNAuthorizationStatus = .notDetermined
    
    private override init() {
        super.init()
        Messaging.messaging().delegate = self
    }
    
    public func setDeviceToken(deviceToken: Data) {
        self.deviceToken = deviceToken
    }
    
    public func setAuthorizationOptions(authorizationOptions: UNAuthorizationOptions) {
        self.authorizationOptions = authorizationOptions
    }

    public func getAuthorizationStatus() -> UNAuthorizationStatus {
        return self.authorizationStatus
    }
    
    public func requestNotifications(_ application: UIApplication, completionHandler: ((Bool, UNAuthorizationStatus) -> Void)? = nil) {
        self.notificationCenter.requestAuthorization(options: authorizationOptions) { [weak self] (granted, error) in
            self?.notificationCenter.getNotificationSettings { settings in
                let status = settings.authorizationStatus
                self?.authorizationStatus = status
                if let error = error {
                    print("requestAuthorization error:\(error)")
                }
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                        print("register notification")
                    }
                }
                completionHandler?(granted, status)
            }
        }
    }
}
