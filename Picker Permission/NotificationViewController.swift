//
//  NotificationViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var labelPermission: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification"
    }

    @IBAction func clickLocalNotification(_ sender: UIButton) {
        labelPermission.text = "Check Permission Status"
    }
}
