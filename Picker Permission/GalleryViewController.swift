//
//  GalleryViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import PhotosUI

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var imageViewGallery: UIImageView!
    @IBOutlet weak var labelPath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        self.labelPath.text = ""
    }
    
    @IBAction func clickOpenGallery(_ sender: UIButton) {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
    
}

extension GalleryViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        if let result = results.first {
            // load image
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                if error == nil {
                    guard let image = reading as? UIImage else { return }
                    DispatchQueue.main.async {
                        self.imageViewGallery.image = image
                    }
                }
            }
            // load path
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                if (error == nil) {
                    DispatchQueue.main.async {
                        self.labelPath.text = url?.absoluteString
                    }
                }
            }
        }
    }
    
}
