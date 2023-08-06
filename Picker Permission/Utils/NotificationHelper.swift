//
//  NotificationHelper.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 06/08/23.
//

import Foundation
import UserNotifications

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
