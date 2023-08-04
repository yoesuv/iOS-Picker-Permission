//
//  ViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.backButtonDisplayMode = .minimal
    }


    @IBAction func clickNotification(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToNotification", sender: self)
    }
    
}

