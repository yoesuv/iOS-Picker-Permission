//
//  RecordViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var labelRecordingState: UILabel!
    @IBOutlet weak var labelRunning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Record Audio"
    }
    
    
    @IBAction func onClickStart(_ sender: UIButton) {
        print("RecordViewController # click START")
    }
    
    @IBAction func onClickStop(_ sender: UIButton) {
        print("RecordViewController # click STOP")
    }
    
}
