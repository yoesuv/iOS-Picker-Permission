//
//  CameraViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    @IBOutlet weak var imageViewCamera: UIImageView!
    @IBOutlet weak var labelCameraPath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Camera"
        self.labelCameraPath.text = ""
    }
    
    @IBAction func clickOpenCamera(_ sender: UIButton) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { access in
                if access {
                    self.openCamera()
                }
            }
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorized:
            self.openCamera()
        default:
            print("Default")
        }
    }
    
    private func openCamera() {
        let alert = UIAlertController(title: "CAMERA", message: "Under Construction", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
