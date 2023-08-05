//
//  NotificationViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var labelPermission: UILabel!
    
    private let notification = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification"
        
        showPermissionStatus()
    }

    @IBAction func clickLocalNotification(_ sender: UIButton) {
        notification.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                print("not determined")
                self.notification.requestAuthorization(options: [.sound, .alert]) { isAllow, error in
                    self.showPermissionStatus()
                    if (isAllow) {
                        self.showNotification()
                    }
                }
            case .denied:
                print("denied")
                self.showPermissionStatus()
            case .authorized:
                print("authorized")
                self.showPermissionStatus()
                self.showNotification()
            case .provisional:
                self.showPermissionStatus()
                print("provisional")
            default:
                self.showPermissionStatus()
                print("default")
                return
            }
        }
    }
    
    
    private func showPermissionStatus() {
        notification.getNotificationSettings { setting in
            let desc = setting.authorizationStatus.description
            DispatchQueue.main.async {
                self.labelPermission.text = "Notification Permission : \(desc)"
            }
        }
    }
    
    private func showNotification() {
        print("NotificationViewController # showNotification")
    }
}

extension UNAuthorizationStatus : CustomStringConvertible {
    public var description: String {
        switch self {
        case .notDetermined:
            return "Not Determined"
        case .denied:
            return "Denied"
        case .authorized:
            return "Authorized"
        case .provisional:
            return "Provisional"
        case .ephemeral:
            return "Ephemeral"
        default:
            return "Unknown value \(rawValue)"
        }
    }
}
