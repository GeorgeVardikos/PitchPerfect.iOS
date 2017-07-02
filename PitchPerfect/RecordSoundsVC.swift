//
//  RecordSoundsVC.swift
//  PitchPerfect
//
//  Created by George Vardikos on 7/3/17.
//  Copyright © 2017 George Vardikos. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsVC: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recordingStoppedSegue" {
            let destController = segue.destination as! PlaySoundsVC
            let recorderAudioUrl = sender as! URL
            destController.recordedAudioURL = recorderAudioUrl
        }
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        statusLabel.text = "Recording in progress..."
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        
        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "PitchPerfect - Recorded voice.wav"
        let pathArr = [directoryPath, recordingName]
        let filePathURL = URL(string: pathArr.joined(separator: "/"))
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePathURL!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        statusLabel.text = "Tap to record"
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        
        audioRecorder.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
}

extension RecordSoundsVC: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "recordingStoppedSegue", sender: audioRecorder.url)
        } else {
            print("Error with saving the file")
        }
        
    }
}

