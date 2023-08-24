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
    @IBOutlet weak var labelTotalDuration: UILabel!
    @IBOutlet weak var buttonPlayer: UIButton!
    
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    private var player: AVAudioPlayer?
    private var audioFileName: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Record Audio"
        
        self.labelTotalDuration.isHidden = true
        self.buttonPlayer.isHidden = true
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
        self.audioRecorder.stop()
        self.audioRecorder = nil
    }
    
    @IBAction func onClickPlayer(_ sender: UIButton) {
        if player?.isPlaying == true {
            self.buttonPlayer.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player?.stop()
        } else {
            do {
                try player = AVAudioPlayer(contentsOf: audioFileName, fileTypeHint: AVFileType.m4a.rawValue)
                player?.delegate = self
                player?.play()
                self.buttonPlayer.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            } catch let error {
                print("RecordViewController # error \(error.localizedDescription)")
            }
        }
    }
    
    private func startOrPauseRecording() {
        print("RecordViewController # Start or Pause Recording")
        let fileManager = FileManager.default
        let dirPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        self.audioFileName = dirPath[0].appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
        ]
        do {
            self.audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            self.audioRecorder.delegate = self
            self.audioRecorder.record()
        } catch {
            print("RecordViewController # error start recording \(error)")
        }
    }
    
}

extension RecordViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            self.labelTotalDuration.isHidden = false
            self.buttonPlayer.isHidden = false
        } else {
            print("RecordViewController # error play")
        }
    }
    
}

extension RecordViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.buttonPlayer.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
}
