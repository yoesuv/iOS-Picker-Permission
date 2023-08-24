//
//  RecordViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import AVFoundation

enum RecordingState {
    case initial
    case recording
    case pause
    case resume
}

class RecordViewController: UIViewController {
    
    @IBOutlet weak var labelRecordingState: UILabel!
    @IBOutlet weak var labelRunning: UILabel!
    @IBOutlet weak var labelTotalDuration: UILabel!
    @IBOutlet weak var buttonPlayer: UIButton!
    @IBOutlet weak var buttonStart: UIButton!
    
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    private var audioFileName: URL!
    private var recordingState: RecordingState = RecordingState.initial
    
    
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
        self.audioRecorder?.stop()
        self.audioRecorder = nil
        self.buttonStart.setTitle("Start", for: .normal)
        self.recordingState = RecordingState.initial
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
        if recordingState == RecordingState.initial {
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
                self.recordingState = RecordingState.recording
                self.buttonStart.setTitle("Pause", for: .normal)
                self.audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
                self.audioRecorder?.delegate = self
                self.audioRecorder?.record()
            } catch {
                print("RecordViewController # error start recording \(error)")
            }
        } else if recordingState == RecordingState.recording || recordingState == RecordingState.resume {
            self.recordingState = RecordingState.pause
            self.buttonStart.setTitle("Resume", for: .normal)
            self.audioRecorder?.pause()
        } else {
            self.recordingState = RecordingState.resume
            self.buttonStart.setTitle("Pause", for: .normal)
            self.audioRecorder?.record()
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
