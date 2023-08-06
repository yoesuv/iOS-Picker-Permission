//
//  FileViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit

class FileViewController: UIViewController {
    
    @IBOutlet weak var labelFilePath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "File"
        self.labelFilePath.text = ""
    }
    
    @IBAction func clickOpenFile(_ sender: UIButton) {
        
    }
    
}
