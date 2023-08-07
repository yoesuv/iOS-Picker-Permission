//
//  LocationViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var labelLatLng: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
        self.labelLatLng.text = ""
    }
    
    
    @IBAction func clickGetLocation(_ sender: UIButton) {
        
    }
    
}
