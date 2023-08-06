//
//  FileViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class FileViewController: UIViewController {
    
    @IBOutlet weak var labelFilePath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "File"
        self.labelFilePath.text = ""
    }
    
    @IBAction func clickOpenFile(_ sender: UIButton) {
        let supportedTypes = [UTType.data, UTType.pdf, UTType.audio, UTType.video]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        present(documentPicker, animated: true, completion: nil)
    }
    
}

extension FileViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            DispatchQueue.main.async {
                self.labelFilePath.text = url.absoluteString
            }
        }
        controller.dismiss(animated: true)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
    
}
