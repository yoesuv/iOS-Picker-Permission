//
//  RecordViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    @IBOutlet weak var labelRecordingState: UILabel!
    @IBOutlet weak var labelRunning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Record Audio"
    }
    
    
    @IBAction func onClickStart(_ sender: UIButton) {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { access in
                if access {
                    self.startOrPauseRecording()
                }
            }
        case .authorized:
            self.startOrPauseRecording()
        case .restricted, .denied:
            print("RecordViewController # Restricted or Denied")
        default:
            print("RecordViewController # Default")
        }
    }
    
    @IBAction func onClickStop(_ sender: UIButton) {
        print("RecordViewController # click STOP")
    }
    
    private func startOrPauseRecording() {
        print("RecordViewController # Start or Pause Recording")
    }
    
}
