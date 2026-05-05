//
//  NotificationViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
@preconcurrency import UserNotifications

class NotificationViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var labelPermission: UILabel!
    
    private let notification = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification"
        
        showPermissionStatus()
    }

    @IBAction func clickLocalNotification(_ sender: UIButton) {
        notification.getNotificationSettings { [weak self] setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                print("not determined")
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { isAllow, error in
                    DispatchQueue.main.async {
                        self?.showPermissionStatus()
                    }
                    if isAllow {
                        DispatchQueue.main.async {
                            self?.showNotification()
                        }
                    }
                }
            case .denied:
                print("denied")
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
            case .authorized:
                print("authorized")
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
                DispatchQueue.main.async {
                    self?.showNotification()
                }
            case .provisional:
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
                print("provisional")
            default:
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
                print("default")
                return
            }
        }
    }
    
    
    
    @IBAction func clickScheduleNotification(_ sender: UIButton) {
        notification.getNotificationSettings { [weak self] setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                print("not determined")
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { isAllow, error in
                    DispatchQueue.main.async {
                        self?.showPermissionStatus()
                    }
                    if isAllow {
                        DispatchQueue.main.async {
                            self?.showScheduledNotification()
                        }
                    }
                }
            case .denied:
                print("denied")
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
            case .authorized:
                print("authorized")
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
                DispatchQueue.main.async {
                    self?.showScheduledNotification()
                }
            case .provisional:
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
                print("provisional")
            default:
                DispatchQueue.main.async {
                    self?.showPermissionStatus()
                }
                print("default")
                return
            }
        }
    }
    
    private func showPermissionStatus() {
        notification.getNotificationSettings { [weak self] setting in
            let desc = setting.authorizationStatus.description
            DispatchQueue.main.async {
                self?.labelPermission.text = "Notification Permission : \(desc)"
            }
        }
    }
    
    private func showNotification() {
        let identifier = "local_notification"
        let content = UNMutableNotificationContent()
        content.title = "Local Notification"
        content.body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
        notification.removeDeliveredNotifications(withIdentifiers: [identifier])
        notification.add(request) { error in
            if let err = error {
                print(err)
            }
        }
    }
    
    private func showScheduledNotification() {
        let identifier = "scheduled_notification"
        let content = UNMutableNotificationContent()
        content.title = "Scheduled Notification"
        content.body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        content.sound = .default
        
        let theDate = Date().adding(minutes: 2)
        let triggerDate = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: theDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate , repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
        notification.removeDeliveredNotifications(withIdentifiers: [identifier])
        notification.add(request) { error in
            if let err = error {
                print(err)
            }
        }
    }
}

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
