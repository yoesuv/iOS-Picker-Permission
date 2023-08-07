//
//  CameraViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet weak var imageViewCamera: UIImageView!
    @IBOutlet weak var labelCameraPath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Camera"
        self.labelCameraPath.text = ""
    }
    
    @IBAction func clickOpenCamera(_ sender: UIButton) {
        
    }
    
}
