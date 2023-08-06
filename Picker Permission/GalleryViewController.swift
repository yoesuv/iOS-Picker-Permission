//
//  GalleryViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var imageViewGallery: UIImageView!
    @IBOutlet weak var labelPath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        self.labelPath.text = ""
    }
    
    @IBAction func clickOpenGallery(_ sender: UIButton) {
        
    }
    
}
