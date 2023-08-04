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
        
        self.title = "Picker & Permissions"
        self.navigationItem.backButtonDisplayMode = .minimal
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "AccentColor")!
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.standardAppearance  = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
    }

    @IBAction func clickGallery(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToGallery", sender: self)
    }
    
    @IBAction func clickCamera(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToCamera", sender: self)
    }
    
    @IBAction func clickFile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToFile", sender: self)
    }
    
    @IBAction func clickLocation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToLocation", sender: self)
    }
    
    @IBAction func clickRecord(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToRecord", sender: self)
    }
    
    @IBAction func clickNotification(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToNotification", sender: self)
    }
    
}

